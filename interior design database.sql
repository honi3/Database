
  use kobash;
  CREATE TABLE clients (
  client_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  phone_number VARCHAR(20)
);

INSERT INTO clients (name, phone_number) VALUES
  ('ahmad atta', '07701234567'),
  ('salar osman', '07711234567'), 
  ('shler hasan', '07721234567');
  
  select * from clients;
  
  
CREATE TABLE employees (
  employee_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  salary DECIMAL(5,2) NOT NULL,
  hire_date DATE NOT NULL,
  phone_number VARCHAR(11) UNIQUE
);


CREATE TABLE services (
  service_id INT AUTO_INCREMENT PRIMARY KEY,
  service_type VARCHAR(50),
  cost DECIMAL(10,2)
);


CREATE TABLE materials (
  material_id INT AUTO_INCREMENT PRIMARY KEY,
  category VARCHAR(50),  -- example/ "Wood", "Steel"
  quantity INT,
  color VARCHAR(30),
  unit_price DECIMAL(10,2)
);


CREATE TABLE projects (
  project_id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(100),
  description TEXT,
  starting_date DATE,
  finishing_date DATE,
  deadline DATE,
  colors VARCHAR(100), 
  city VARCHAR(50),
  status ENUM('planned', 'active', 'completed', 'cancelled'), 
  cost DECIMAL(12,2),
  client_id INT,  
  FOREIGN KEY (client_id) REFERENCES clients(client_id)
);


CREATE TABLE project_materials (
  project_id INT,
  material_id INT,
  quantity_used INT,
  PRIMARY KEY (project_id, material_id),
  FOREIGN KEY (project_id) REFERENCES projects(project_id),
  FOREIGN KEY (material_id) REFERENCES materials(material_id)
);



CREATE TABLE finance (
  finance_id INT AUTO_INCREMENT PRIMARY KEY,
  monthly_revenue DECIMAL(12,2) NOT NULL,
  monthly_expenses DECIMAL(12,2) NOT NULL,
  net_profit DECIMAL(12,2) GENERATED ALWAYS AS (monthly_revenue - monthly_expenses) STORED,  -- It calculates the monthly profit.
  record_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  );


CREATE TABLE client_transactions (
  finance_id INT PRIMARY KEY,
  client_id INT NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  due_date DATE NOT NULL,
  transaction_type ENUM('client_debt', 'client_credit'),
  notes TEXT,  -- It adds a note for every transaction.
  FOREIGN KEY (finance_id) REFERENCES finance(finance_id) ON DELETE CASCADE,
  FOREIGN KEY (client_id) REFERENCES clients(client_id) ON DELETE RESTRICT  -- it prevents client deletion (parent)
);


CREATE TABLE employee_transactions (
  finance_id INT PRIMARY KEY,
  employee_id INT NOT NULL, 
  amount DECIMAL(10,2) NOT NULL,
  payment_date DATE NOT NULL,
  transaction_type ENUM('salary', 'overtime', 'bonus', 'reimbursement'),  -- Expanded types
  FOREIGN KEY (finance_id) REFERENCES finance(finance_id) ON DELETE CASCADE,
  FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);


CREATE TABLE contact_info (
  contact_id INT AUTO_INCREMENT PRIMARY KEY,
  phone_primary VARCHAR(20),  
  phone_secondary VARCHAR(20),
  email VARCHAR(100),
  address TEXT
);


INSERT INTO contact_info (phone_primary, phone_secondary, email, address) VALUES (
  '07701234567',             
  '07706543210',             
  'kobash@interiordesign.com', 
  'Kanyba Near Asia Hospital, Slemani, Kurdistan' 
);
  

select * from contact_info;

