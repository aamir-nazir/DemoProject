ActiveAdmin.register User do
 form do |f|
   f.semantic_errors
   f.inputs :user do
     f.input :first_name
     f.input :last_name
     f.input :email
   end
   f.actions
 end
end

