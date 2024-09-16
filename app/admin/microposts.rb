ActiveAdmin.register Micropost do
  permit_params :content, :user_id # Разреши те параметры, которые тебе нужны

  # Опционально, настрой отображение полей
  index do
    selectable_column
    id_column
    column :content
    column :user
    column :created_at
    actions
  end

  form do |f|
    f.inputs 'Details' do
      f.input :content
      f.input :user
    end
    f.actions
  end

  # Можно добавить фильтрацию, сортировку и другие настройки
  filter :user
  filter :created_at
end
