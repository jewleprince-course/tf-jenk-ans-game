output "game_server_public_ip" {
    value = aws_instance.game_server.public_ip
}