// project variables to pass for databse
env.TEST_DATABASE_URI="mysql+pymysql://admin:password@testdb.cgytirb7uezx.eu-west-2.rds.amazonaws.com:3306/testdb"
env.DATABASE_URI="mysql+pymysql://admin:password@deploydb.cgytirb7uezx.eu-west-2.rds.amazonaws.com:3306/users"
env.SECRET_KEY="password"
env.MYSQL_ROOT_PASSWORD="password"
env.DB_PASSWORD="password"
env.testvm_connection="mysql -h testdb.cgytirb7uezx.eu-west-2.rds.amazonaws.com:3306 -P 3306 -u admin -ppassword"

