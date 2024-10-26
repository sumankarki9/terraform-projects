output "iam_user_list" {
    value = local.users_data[*].username
}

output "user_roles" {
    value = local.user_role_pair
}