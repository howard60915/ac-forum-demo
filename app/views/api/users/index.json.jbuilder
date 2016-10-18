json.users do
  # json.id @users.first.id
  json.email @users.first.email
  json.(@users.last, :id , :email) #相同outcome
end
# -------------------
# json.partial! 'user' , u: @users.first #輸出Array
# json.member @users.first , partial: 'user' , as: :u #輸出Hash
# json.users @users, partial: 'user' , as: :u #輸出Hash
# json.user @users , partial: 'user', as: :u  #輸出Hash
# json.array! @users ,partial: 'user' , as: :u #輸出Array