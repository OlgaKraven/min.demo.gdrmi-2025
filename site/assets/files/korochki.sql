DROP DATABASE IF EXISTS korochki;
CREATE DATABASE korochki CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE korochki;
CREATE TABLE roles (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(30) NOT NULL UNIQUE) ENGINE=InnoDB;
CREATE TABLE users (id INT AUTO_INCREMENT PRIMARY KEY, login VARCHAR(50) NOT NULL UNIQUE, password_hash VARCHAR(255) NOT NULL, full_name VARCHAR(200) NOT NULL, phone VARCHAR(20) NOT NULL, email VARCHAR(120) NOT NULL UNIQUE, role_id INT NOT NULL, created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, CONSTRAINT fk_users_role FOREIGN KEY (role_id) REFERENCES roles(id) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=InnoDB;
CREATE TABLE payment_methods (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(50) NOT NULL UNIQUE) ENGINE=InnoDB;
CREATE TABLE application_statuses (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(50) NOT NULL UNIQUE) ENGINE=InnoDB;
CREATE TABLE applications (id INT AUTO_INCREMENT PRIMARY KEY, user_id INT NOT NULL, course_name VARCHAR(200) NOT NULL, start_date DATE NOT NULL, payment_method_id INT NOT NULL, status_id INT NOT NULL, created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, CONSTRAINT fk_app_user FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE, CONSTRAINT fk_app_payment FOREIGN KEY (payment_method_id) REFERENCES payment_methods(id) ON UPDATE CASCADE ON DELETE RESTRICT, CONSTRAINT fk_app_status FOREIGN KEY (status_id) REFERENCES application_statuses(id) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=InnoDB;
CREATE TABLE reviews (id INT AUTO_INCREMENT PRIMARY KEY, user_id INT NOT NULL, text TEXT NOT NULL, created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, CONSTRAINT fk_reviews_user FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE) ENGINE=InnoDB;
INSERT INTO roles (name) VALUES ("user"), ("admin");
INSERT INTO payment_methods (name) VALUES ("Наличными"), ("Переводом по номеру телефона");
INSERT INTO application_statuses (name) VALUES ("Новая"), ("Идёт обучение"), ("Обучение завершено");
INSERT INTO users (login, password_hash, full_name, phone, email, role_id) VALUES
  ("Admin",    "9a4773c146fc0b2919e2732361e73483e86e15b10594812adae35e9c5af1cd9c", "Администратор",                  "8(000)000-00-00",  "admin@korochki.local", (SELECT id FROM roles WHERE name="admin")),
  ("testuser", "4820cbcc3788fd8e79d51f3533523a0b4b8abc5e8d9f44fc62ae42e87ab8c8cc", "Тестовый Пользователь Иванович", "8(999)123-45-67",  "test@korochki.local",  (SELECT id FROM roles WHERE name="user"));
