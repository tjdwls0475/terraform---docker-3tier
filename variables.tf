variable "project" {
    default = "Harry"
}

variable "vpc_cidr" {
    type = string
    default = "10.0.0.0/16"
}

variable "region" {
    type = string
    default = "ap-northeast-2"
}

variable "azones" {
    type = list
    default = ["a", "c"]
}

variable "mgmt_subnet_cidrs" {
    type = list
    default = ["10.0.0.0/27"]
}

variable "public_subnet_cidrs" {
    type = list
    default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "web_subnet_cidrs" {
    type = list
    default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "was_subnet_cidrs" {
    type = list
    default = ["10.0.5.0/24", "10.0.6.0/24"]
}

variable "db_subnet_cidrs" {
    type = list
    default = ["10.0.7.0/27", "10.0.7.32/27"]
}

variable "ami" {
    type = string
    default = "ami-003ef1c0e2776ea27"
}