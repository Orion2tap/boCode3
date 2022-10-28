DROP DATABASE IF EXISTS ssm;
CREATE DATABASE ssm CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE ssm;

CREATE TABLE todo
(
    `id` INT NOT NULL AUTO_INCREMENT,
    `content` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE weibo
(
    `id`      INT          NOT NULL AUTO_INCREMENT,
    `content`   VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `ssm`.`user`
(
    `id`                INT                                 NOT NULL    AUTO_INCREMENT,
    `username`          VARCHAR(45)                         NOT NULL    DEFAULT 'guest',
    `password`          VARCHAR(45)                         NOT NULL,
    `role`              ENUM('normal', 'admin', 'guest')    NOT NULL    DEFAULT 'normal',
    `email`             VARCHAR(45)                         NOT NULL    DEFAULT 'xxx@qq.com',
    `registrationTime`  VARCHAR(45)                         NOT NULL    DEFAULT '000',
    `avatar`            VARCHAR(45)                         NOT NULL    DEFAULT 'guest.jpg',
    `score`             INT                                 NOT NULL    DEFAULT 0,
    `site`              VARCHAR(45),
    `location`          VARCHAR(45),
    `github`            VARCHAR(45),
    `note`              VARCHAR(45),
    PRIMARY KEY (`id`)
);

CREATE TABLE `ssm`.`board`
(
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `ssm`.`topic`
(
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(30) NOT NULL,
    `content` VARCHAR(1000) NOT NULL,
    `userId` INT(11) NOT NULL DEFAULT -1,
    `boardId` INT(11) NOT NULL,
    `createdTime` BIGINT(45) NOT NULL DEFAULT '1349333576093',
    `updatedTime` BIGINT(45) NOT NULL DEFAULT '1349333576093',
    PRIMARY KEY (`id`)
)ENGINE = InnoDB;

CREATE TABLE `ssm`.`topiccomment`
(
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `content` VARCHAR(500) NOT NULL,
    `topicId` INT(11) NOT NULL,
    `userId` INT(11) NOT NULL,
    `createdTime` BIGINT(45) NOT NULL DEFAULT '1349333576093',
    `updatedTime` BIGINT(45) NOT NULL DEFAULT '1349333576093',
    `floor` INT(11) NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `ssm`.`topiccomment`
    ADD INDEX `FK_Topiccomment_topicId_Topic_id_idx` (`topicId` ASC);
ALTER TABLE `ssm`.`topiccomment`
    ADD CONSTRAINT `FK_Topiccomment_topicId_Topic_id`
        FOREIGN KEY (`topicId`)
            REFERENCES `ssm`.`topic` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE;

CREATE TABLE `ssm`.`topicstar`
(
    `id` INT NOT NULL AUTO_INCREMENT,
    `userId` INT NOT NULL,
    `topicId` VARCHAR(45) NOT NULL,
    `staredTime` BIGINT(45) NOT NULL DEFAULT '1349333576093',

    PRIMARY KEY (`id`)
);

ALTER TABLE `ssm`.`topicstar`
    ADD INDEX `FK_Topicstar_topicId_Topic_id_idx` (`topicId` ASC);
ALTER TABLE `ssm`.`topicstar`
    ADD CONSTRAINT `FK_Topicstar_topicId_Topic_id`
        FOREIGN KEY (`topicId`)
            REFERENCES `ssm`.`topic` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE;

