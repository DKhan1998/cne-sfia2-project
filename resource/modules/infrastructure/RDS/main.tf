# Create a resource
resource "aws_db_instance" "RDS_test" {
  allocated_storage         = var.allocated_storage
  identifier                = "testdb"
  storage_type              = var.storage_type
  engine                    = var.engine
  engine_version            = var.engine_version
  instance_class            = var.instance_class
  name                      = var.name
  username                  = var.username
  password                  = var.password
  parameter_group_name      = var.parameter_group_name
  vpc_security_group_ids    = var.vpc-security-group-ids
  db_subnet_group_name      = var.db_subnet_group_name
  skip_final_snapshot       = var.final_snapshot_identifier
  final_snapshot_identifier = "false"
  publicly_accessible       = true


  tags = {
    Name = "SFIA2-${var.name}"
  }
}

resource "aws_db_instance" "RDS_deploy" {
  allocated_storage         = var.allocated_storage
  identifier                = "deploydb"
  storage_type              = var.storage_type
  engine                    = var.engine
  engine_version            = var.engine_version
  instance_class            = var.instance_class
  name                      = "deploydb"
  username                  = var.username
  password                  = var.password
  parameter_group_name      = var.parameter_group_name
  vpc_security_group_ids    = var.vpc-security-group-ids
  db_subnet_group_name      = var.db_subnet_group_name
  skip_final_snapshot       = var.final_snapshot_identifier
  final_snapshot_identifier = "false"
  publicly_accessible       = true


  tags = {
    Name = "SFIA2-${var.name}"
  }
}

# Export Terraform variable values to an Ansible var_file
resource "local_file" "tf_db_vars" {
  content  = <<-DOC
    // project variables to pass for databse
    env.TEST_DATABASE_URI="mysql+pymysql://${aws_db_instance.RDS_test.username}:${aws_db_instance.RDS_test.password}@${aws_db_instance.RDS_test.endpoint}/testdb"
    env.DATABASE_URI="mysql+pymysql://${aws_db_instance.RDS_deploy.username}:${aws_db_instance.RDS_deploy.password}@${aws_db_instance.RDS_deploy.endpoint}/users"
    env.SECRET_KEY="${aws_db_instance.RDS_test.password}"
    env.MYSQL_ROOT_PASSWORD="${aws_db_instance.RDS_test.password}"
    env.DB_PASSWORD="${aws_db_instance.RDS_test.password}"
    env.testvm_connection="mysql -h ${aws_db_instance.RDS_test.endpoint} -P 3306 -u admin -p${aws_db_instance.RDS_test.password}"

    DOC
  filename = "../../../Ansible/.envvars/tf_db.groovy"
}
