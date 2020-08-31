# Gererate data needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# GENERATE FIXED DATA
[
  { code: :success, description: 'Sucesso' },
  { code: :unsuccess, description: 'Não sucesso' },
  { code: :exchange, description: 'Troca' }
].each do |type|
  AttendanceType.create! type
end

[
  { code: :start_day, description: 'Começar o dia' },
  { code: :end_day, description: 'Finalizar o dia' },
  { code: :start_coffe, description: 'Sair para café' },
  { code: :end_coffe, description: 'Voltar do café' },
  { code: :start_lunch, description: 'Sair para almoçar' },
  { code: :end_lunch, description: 'Voltar do almoço' },
  { code: :start_other_activies, description: 'Começar outras atividades' },
  { code: :end_other_activies, description: 'Finalizar outras atividades' }
].each do |type|
  MovementType.create! type
end

[
  { code: :product_missing, description: 'Falta de produto' },
  { code: :unlike, description: 'Não gostou' },
  { code: :research, description: 'Pesquisa' },
  { code: :product_price, description: 'Preço do produto' },
  { code: :product_color, description: 'Cor do produto' },
  { code: :no_time_to_approach, description: 'Não deu tempo de abordar' },
  { code: :other, description: 'Outro' }
].each do |reason|
  LostReason.create! reason
end

# GENERATE RANDOM DATA

# Brands
(0..10).each do
  brand = Brand.create! name: Faker::Company.name

  # Create products
  (0..rand(200..1_000)).each do
    Product.create! description: Faker::Commerce.product_name, brand: brand
  end

  (0..rand(3..20)).each do
    # Create stores
    store = Store.create! name: Faker::Company.name, brand: brand

    # Create sellers
    (0..rand(3..20)).each { Seller.create! name: Faker::Name.name, store: store }
  end
end



