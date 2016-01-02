require 'csv'

if Category.count == 0
    Category.create name: 'snacks', caption: 'Закуски'
    Category.create name: 'salads', caption: 'Салаты'
    Category.create name: 'soups', caption: 'Супы'
    Category.create name: 'hots', caption: 'Основное'
    Category.create name: 'porridges', caption: 'Каши'
    Category.create name: 'desserts', caption: 'Десерты'
    Category.create name: 'pastries', caption: 'Выпечка'
    Category.create name: 'sauces', caption: 'Соусы'
    Category.create name: 'drinks', caption: 'Напитки'
    Category.create name: 'dough', caption: 'Тесто'
    Category.create name: 'jam', caption: 'Заготовки'
end

if Country.count == 0
    Country.create name: 'russian', caption: 'Русская'
    Country.create name: 'spanish', caption: 'Испанская'
    Country.create name: 'italian', caption: 'Итальянская'
    Country.create name: 'french', caption: 'Французская'
    Country.create name: 'japanese', caption: 'Японская'
    Country.create name: 'ukrainian', caption: 'Украинская'
    Country.create name: 'english', caption: 'Английская'
    Country.create name: 'hellas', caption: 'Греческая'
    Country.create name: 'georgian', caption: 'Грузинская'
    Country.create name: 'indian', caption: 'Индийская'
    Country.create name: 'chinese', caption: 'Китайская'
    Country.create name: 'mexican', caption: 'Мексиканская'
end

if Measure.count == 0
    Measure.create name: 'гр'
    Measure.create name: 'кг'
    Measure.create name: 'мл'
    Measure.create name: 'л'
    Measure.create name: 'шт'
    Measure.create name: 'ч.л'
    Measure.create name: 'ст.л'
    Measure.create name: 'стакан'
    Measure.create name: 'пучок'
    Measure.create name: 'упак.'
    Measure.create name: 'перо'
    Measure.create name: 'ветка'
    Measure.create name: 'черешок'
    Measure.create name: 'щепотка'
end

Ingridient.all.destroy_all
# Загрузка ингредиентов из файла
CSV.read("#{Rails.root}/db/ingredients.csv", encoding: 'utf-8', col_sep: ';')[0..-1].each do |row|
    Ingridient.create(name: row[0].to_s)
end