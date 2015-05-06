class DeleteColumnsFromUsers < ActiveRecord::Migration
	def up
		remove_column :users, :provider
		remove_column :users, :uid
	end
end
