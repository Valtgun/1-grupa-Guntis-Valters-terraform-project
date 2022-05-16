# 1.grupa Guntis Valters

## Projekta saturs
### Konfigurācija dažādām vidēm
- Konfigurācija dažādām vidēm (dev, stage un prod)
- Vides konfigurācijas faili, kas ir jāizpilda atrodas Services katalogā
- Vides konfigurācijas faili izsauc konkrēto moduļu uzstādīšanu kas atrodas modules katelogā.

### Moduļi
- aws - pamata modulis pieslēgumam un inicializācijai
- ec2 - modulis, kas izveido EC2 instanci un piesaista to tīklam, saņemot mainīgo no vpc moduļa
- vpc - modulis, kas konfigurē virtuālo privāto tīklu, sastāv no vairākām darbībām:
1. 2 privātie apakštīkli
2. 2 publiskie apakštīkli
3. Routing tabula, kas sasaista publisko tīklu 1 ar Internet gateway
4. Routing tabula, kas sasaista privāto tīklu 1 ar NAT gateway un elastic IP

### Terraform konfgiurācijas piemērošana
- cd services/dev/nginx-web-server
- terraform plan
- terraform apply
> atbild izmaiņu pārprasīšanai: yes


### Terraform stāvokļa glabāšana S3
- S3 bucket terraform konfigurācija glabājas modules/init
- Konfigurācijas izpildei pietrūkst tiesības gan us-east-1, gan us-west-2 reģionos.
```
aws_dynamodb_table.terraform_locks: Creating...
aws_s3_bucket.terraform_state: Creating...
╷
│ Error: error creating S3 Bucket (gv-terraform-state): AccessDenied: Access Denied
│ 	status code: 403, request id: M18WP4WPYTQBZYFK, host id: GuTZLeDIYGdKE8h/bhBtWrnpWAfsOt/RqFG1lb0hNwZkd/3u6KfYgVXYzfU7B5M7rTtFJHiCHks=
│
│   with aws_s3_bucket.terraform_state,
│   on main.tf line 5, in resource "aws_s3_bucket" "terraform_state":
│    5: resource "aws_s3_bucket" "terraform_state" {
│
╵
╷
│ Error: error creating DynamoDB Table: AccessDeniedException: User: arn:aws:iam::952122846739:user/Guntis_Valters is not authorized to perform: dynamodb:CreateTable on resource: arn:aws:dynamodb:us-west-2:952122846739:table/gv-terraform-locks
│ 	status code: 400, request id: 399M0AL6SVV9JG2SJ35MPQCFE7VV4KQNSO5AEMVJF66Q9ASUAAJG
│
│   with aws_dynamodb_table.terraform_locks,
│   on main.tf line 28, in resource "aws_dynamodb_table" "terraform_locks":
│   28: resource "aws_dynamodb_table" "terraform_locks" {
```
