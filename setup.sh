#!/bin/bash

# Ensure Rust is installed
if ! command -v cargo &> /dev/null
then
    echo "Rust is not installed. Install it from https://rustup.rs/"
    exit
fi

# Project name
read -p "Enter your Actix project name: " PROJECT_NAME

# Create new Actix project
cargo new $PROJECT_NAME
cd $PROJECT_NAME

# Add dependencies to Cargo.toml
echo "Updating Cargo.toml with Actix, Serde, Tokio, and SQLx..."

cat >> Cargo.toml <<EOL

[dependencies]
actix-web = "4"
tokio = { version = "1", features = ["full"] }
serde = { version = "1", features = ["derive"] }
serde_json = "1"
sqlx = { version = "0.7", features = ["runtime-tokio", "macros", "sqlite", "postgres", "mysql"] }
dotenvy = "0.15"
actix-rt = "2"

[dev-dependencies]
EOL

# Create basic main.rs
cat > src/main.rs <<EOL
use actix_web::{get, App, HttpServer, Responder};

#[get("/")]
async fn hello() -> impl Responder {
    "Welcome to your Actix API!"
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    println!("🚀 Server running on http://localhost:8080");

    HttpServer::new(|| {
        App::new()
            .service(hello)
    })
    .bind(("127.0.0.1", 8080))?
    .run()
    .await
}
EOL

# Done
echo "actix project '$PROJECT_NAME' created and configured."
echo "👉 To run it: cd $PROJECT_NAME && cargo run"
