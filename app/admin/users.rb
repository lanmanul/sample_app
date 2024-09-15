ActiveAdmin.register User do
  permit_params :name, :email, :admin

  # controller do
  #   def scoped_collection
  #     User.paginate(page: params[:page], per_page: 10)
  #   end
  #   end

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :admin
    actions
  end

  filter :name
  filter :email
  filter :admin

  form do |f|
    f.inputs 'Details' do
      f.input :name
      f.input :email
      f.input :admin
    end
    f.actions
  end
end
