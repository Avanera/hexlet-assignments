json.array! @users, partial: 'user', as: :user

# json.array! @users do |user|
#   json.extract! user, :id, :email, :address
#   json.full_name "#{user.first_name} #{user.last_name}"
#   json.posts user.posts, partial: 'api/v1/users/posts', as: :post
# end
