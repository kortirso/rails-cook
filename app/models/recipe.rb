class Recipe < ActiveRecord::Base
    belongs_to :category
    belongs_to :country
    belongs_to :user
    has_many :positions
    before_destroy :ensure_not_referenced_by_any_position
    has_many :carts, through: :positions
    has_many :comments
    has_many :line_ingrids
    accepts_nested_attributes_for :line_ingrids, allow_destroy: true
    has_many :ingridients, through: :line_ingrids
    has_many :grades
    mount_uploader :image, ImageUploader
    has_many :steps
    accepts_nested_attributes_for :steps, allow_destroy: true
    include PgSearch
    pg_search_scope :search_everywhere, against: [:name]

    validates :name, :category_id, :user_id, :prepare, :portions, presence: true
    validates :prepare, :portions, numericality: { greater_than: 0 }
    validates :path_name, uniqueness: true

    after_create :set_path

    scope :showed, -> { where visible: true }

    def short_name
        self.name.truncate(50)
    end

    def refresh(mark)
        self.stars += mark
        self.marks += 1
        self.average = (self.stars.to_f / self.marks).round 2
        self.save!
        self
    end

    private
    def ensure_not_referenced_by_any_position
        if positions.empty?
            return true
        else
            errors.add(:base, 'Существуют товарные позиции')
            return false
        end
    end

    def set_path
        self.update(path_name: "recipe_#{self.id}")
    end
end
