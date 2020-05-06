-- 创建数据库
create database `eamp` default character set utf8 collate utf8_general_ci;
 
use eamp;
 
-- 建表
/* ============================================================== */
/* Table:   admin       */
/* ============================================================== */

CREATE TABLE `admin` (
    `id` BIGINT AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `password` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`id`)
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

/* ============================================================== */
/* Table:   user       */
/* ============================================================== */

CREATE TABLE `user` (
    `name` VARCHAR(50) NOT NULL,
    `password` VARCHAR(50) NOT NULL,
    `phone` VARCHAR(50) NOT NULL,
    `experience` BIGINT NOT NULL,
    `grade` BIGINT NOT NULL,
    `tag` VARCHAR(1000) NOT NULL,
    PRIMARY KEY (`name`)
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

/* ============================================================== */
/* Table:   talk       */
/* ============================================================== */

CREATE TABLE `talk` (
    `id` BIGINT AUTO_INCREMENT,
    `from` VARCHAR(50) NOT NULL,
    `to` VARCHAR(50) NOT NULL,
    `when` VARCHAR(50) NOT NULL,
    `content` VARCHAR(255) NOT NULL,
    `status` INT NOT NULL,
    PRIMARY KEY (`id`)
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

/* ============================================================== */
/* Table:   friend       */
/* ============================================================== */

CREATE TABLE `friend` (
    `id` BIGINT AUTO_INCREMENT,
    `friend1` VARCHAR(50) NOT NULL,
    `friend2` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`id`)
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

/* ============================================================== */
/* Table:   jointo       */
/* ============================================================== */

CREATE TABLE `jointo` (
    `id` BIGINT AUTO_INCREMENT,
    `person` VARCHAR(50) NOT NULL,
    `involve` BIGINT NOT NULL,
    PRIMARY KEY (`id`)
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

/* ============================================================== */
/* Table:   activity       */
/* ============================================================== */

CREATE TABLE `activity` (
    `id` BIGINT AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `sponsor` VARCHAR(50) NOT NULL,
    `tags` VARCHAR(255) NOT NULL,
    `status` INT NOT NULL,
    `start` VARCHAR(50) NOT NULL,
    `end` VARCHAR(50) NOT NULL,
    `num` BIGINT NOT NULL,
    `joined` BIGINT NOT NULL,
    `location` VARCHAR(255) ,
    `description` VARCHAR(2000) ,
    PRIMARY KEY (`id`)
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;


 
-- 插入数据
