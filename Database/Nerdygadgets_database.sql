-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema nerdygadgets
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema nerdygadgets
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `nerdygadgets` DEFAULT CHARACTER SET latin1 ;
USE `nerdygadgets` ;

-- -----------------------------------------------------
-- Table `nerdygadgets`.`bestelling`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`bestelling` (
  `BestellingID` INT(11) NOT NULL,
  `Voornaam` VARCHAR(45) NOT NULL,
  `Achternaam` VARCHAR(45) NOT NULL,
  `Tussenvoegsel` VARCHAR(45) NULL DEFAULT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Woonplaats` VARCHAR(45) NOT NULL,
  `Postcode` VARCHAR(45) NOT NULL,
  `Straat` VARCHAR(45) NOT NULL,
  `Huisnummer` VARCHAR(45) NOT NULL,
  `Land` VARCHAR(45) NOT NULL,
  `Bankvorm` VARCHAR(45) NOT NULL,
  `Prijs` VARCHAR(45) NOT NULL,
  `Artikel` VARCHAR(500) NOT NULL,
  `Aantal` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`BestellingID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`people`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`people` (
  `PersonID` INT(11) NOT NULL AUTO_INCREMENT,
  `FullName` VARCHAR(50) NOT NULL,
  `PreferredName` VARCHAR(50) NOT NULL,
  `SearchName` VARCHAR(101) NOT NULL,
  `IsPermittedToLogon` TINYINT(1) NOT NULL,
  `LogonName` VARCHAR(50) NULL DEFAULT NULL,
  `IsExternalLogonProvider` TINYINT(1) NOT NULL,
  `HashedPassword` LONGBLOB NULL DEFAULT NULL,
  `IsSystemUser` TINYINT(1) NOT NULL,
  `IsEmployee` TINYINT(1) NOT NULL,
  `IsSalesperson` TINYINT(1) NOT NULL,
  `UserPreferences` LONGTEXT NULL DEFAULT NULL,
  `PhoneNumber` VARCHAR(20) NULL DEFAULT NULL,
  `FaxNumber` VARCHAR(20) NULL DEFAULT NULL,
  `EmailAddress` VARCHAR(256) NULL DEFAULT NULL,
  `Photo` LONGBLOB NULL DEFAULT NULL,
  `CustomFields` LONGTEXT NULL DEFAULT NULL,
  `OtherLanguages` LONGTEXT NULL DEFAULT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `ValidFrom` DATETIME NOT NULL,
  `ValidTo` DATETIME NOT NULL,
  PRIMARY KEY (`PersonID`),
  INDEX `IX_Application_People_IsEmployee` (`IsEmployee` ASC) VISIBLE,
  INDEX `IX_Application_People_IsSalesperson` (`IsSalesperson` ASC) VISIBLE,
  INDEX `IX_Application_People_FullName` (`FullName` ASC) VISIBLE,
  INDEX `IX_Application_People_Perf_20160301_05` (`IsPermittedToLogon` ASC, `PersonID` ASC, `FullName` ASC, `EmailAddress`(255) ASC) VISIBLE,
  INDEX `FK_Application_People_Application_People` (`LastEditedBy` ASC) VISIBLE,
  CONSTRAINT `FK_Application_People_Application_People`
    FOREIGN KEY (`LastEditedBy`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3262
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`buyinggroups`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`buyinggroups` (
  `BuyingGroupID` INT(11) NOT NULL,
  `BuyingGroupName` VARCHAR(50) NOT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `ValidFrom` DATETIME NOT NULL,
  `ValidTo` DATETIME NOT NULL,
  PRIMARY KEY (`BuyingGroupID`),
  UNIQUE INDEX `UQ_Sales_BuyingGroups_BuyingGroupName` (`BuyingGroupName` ASC) VISIBLE,
  INDEX `FK_Sales_BuyingGroups_Application_People` (`LastEditedBy` ASC) VISIBLE,
  CONSTRAINT `FK_Sales_BuyingGroups_Application_People`
    FOREIGN KEY (`LastEditedBy`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`buyinggroups_archive`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`buyinggroups_archive` (
  `BuyingGroupID` INT(11) NOT NULL,
  `BuyingGroupName` VARCHAR(50) NOT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `ValidFrom` DATETIME NOT NULL,
  `ValidTo` DATETIME NOT NULL,
  INDEX `ix_BuyingGroups_Archive` (`ValidFrom` ASC, `ValidTo` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`countries` (
  `CountryID` INT(11) NOT NULL,
  `CountryName` VARCHAR(60) NOT NULL,
  `FormalName` VARCHAR(60) NOT NULL,
  `IsoAlpha3Code` VARCHAR(3) NULL DEFAULT NULL,
  `IsoNumericCode` INT(11) NULL DEFAULT NULL,
  `CountryType` VARCHAR(20) NULL DEFAULT NULL,
  `LatestRecordedPopulation` BIGINT(20) NULL DEFAULT NULL,
  `Continent` VARCHAR(30) NOT NULL,
  `Region` VARCHAR(30) NOT NULL,
  `Subregion` VARCHAR(30) NOT NULL,
  `Border` VARCHAR(100) NULL DEFAULT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `ValidFrom` DATETIME NOT NULL,
  `ValidTo` DATETIME NOT NULL,
  PRIMARY KEY (`CountryID`),
  UNIQUE INDEX `UQ_Application_Countries_FormalName` (`FormalName` ASC) VISIBLE,
  UNIQUE INDEX `UQ_Application_Countries_CountryName` (`CountryName` ASC) VISIBLE,
  INDEX `FK_Application_Countries_Application_People` (`LastEditedBy` ASC) VISIBLE,
  CONSTRAINT `FK_Application_Countries_Application_People`
    FOREIGN KEY (`LastEditedBy`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`stateprovinces`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`stateprovinces` (
  `StateProvinceID` INT(11) NOT NULL,
  `StateProvinceCode` VARCHAR(5) NOT NULL,
  `StateProvinceName` VARCHAR(50) NOT NULL,
  `CountryID` INT(11) NOT NULL,
  `SalesTerritory` VARCHAR(50) NOT NULL,
  `Border` VARCHAR(100) NULL DEFAULT NULL,
  `LatestRecordedPopulation` BIGINT(20) NULL DEFAULT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `ValidFrom` DATETIME NOT NULL,
  `ValidTo` DATETIME NOT NULL,
  PRIMARY KEY (`StateProvinceID`),
  UNIQUE INDEX `UQ_Application_StateProvinces_StateProvinceName` (`StateProvinceName` ASC) VISIBLE,
  INDEX `FK_Application_StateProvinces_CountryID` (`CountryID` ASC) VISIBLE,
  INDEX `IX_Application_StateProvinces_SalesTerritory` (`SalesTerritory` ASC) VISIBLE,
  INDEX `FK_Application_StateProvinces_Application_People` (`LastEditedBy` ASC) VISIBLE,
  CONSTRAINT `FK_Application_StateProvinces_Application_People`
    FOREIGN KEY (`LastEditedBy`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Application_StateProvinces_CountryID_Application_Countries`
    FOREIGN KEY (`CountryID`)
    REFERENCES `nerdygadgets`.`countries` (`CountryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`cities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`cities` (
  `CityID` INT(11) NOT NULL,
  `CityName` VARCHAR(50) NOT NULL,
  `StateProvinceID` INT(11) NOT NULL,
  `Location` VARCHAR(100) NULL DEFAULT NULL,
  `LatestRecordedPopulation` BIGINT(20) NULL DEFAULT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `ValidFrom` DATETIME NOT NULL,
  `ValidTo` DATETIME NOT NULL,
  PRIMARY KEY (`CityID`),
  INDEX `FK_Application_Cities_StateProvinceID` (`StateProvinceID` ASC) VISIBLE,
  INDEX `FK_Application_Cities_Application_People` (`LastEditedBy` ASC) VISIBLE,
  CONSTRAINT `FK_Application_Cities_Application_People`
    FOREIGN KEY (`LastEditedBy`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Application_Cities_StateProvinceID_Application_StateProvinces`
    FOREIGN KEY (`StateProvinceID`)
    REFERENCES `nerdygadgets`.`stateprovinces` (`StateProvinceID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`cities_archive`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`cities_archive` (
  `CityID` INT(11) NOT NULL,
  `CityName` VARCHAR(50) NOT NULL,
  `StateProvinceID` INT(11) NOT NULL,
  `Location` VARCHAR(100) NULL DEFAULT NULL,
  `LatestRecordedPopulation` BIGINT(20) NULL DEFAULT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `ValidFrom` DATETIME NOT NULL,
  `ValidTo` DATETIME NOT NULL,
  INDEX `ix_Cities_Archive` (`ValidFrom` ASC, `ValidTo` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`coldroomtemperatures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`coldroomtemperatures` (
  `ColdRoomTemperatureID` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `ColdRoomSensorNumber` INT(11) NOT NULL,
  `RecordedWhen` DATETIME NOT NULL,
  `Temperature` DECIMAL(10,2) NOT NULL,
  `ValidFrom` DATETIME NOT NULL,
  `ValidTo` DATETIME NOT NULL,
  PRIMARY KEY (`ColdRoomTemperatureID`),
  INDEX `IX_Warehouse_ColdRoomTemperatures_ColdRoomSensorNumber` (`ColdRoomSensorNumber` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 3654741
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`coldroomtemperatures_archive`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`coldroomtemperatures_archive` (
  `ColdRoomTemperatureID` BIGINT(20) NOT NULL,
  `ColdRoomSensorNumber` INT(11) NOT NULL,
  `RecordedWhen` DATETIME NOT NULL,
  `Temperature` DECIMAL(10,2) NOT NULL,
  `ValidFrom` DATETIME NOT NULL,
  `ValidTo` DATETIME NOT NULL,
  INDEX `ix_ColdRoomTemperatures_Archive` (`ValidFrom` ASC, `ValidTo` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`colors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`colors` (
  `ColorID` INT(11) NOT NULL,
  `ColorName` VARCHAR(20) NOT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `ValidFrom` DATETIME NOT NULL,
  `ValidTo` DATETIME NOT NULL,
  PRIMARY KEY (`ColorID`),
  UNIQUE INDEX `UQ_Warehouse_Colors_ColorName` (`ColorName` ASC) VISIBLE,
  INDEX `FK_Warehouse_Colors_Application_People` (`LastEditedBy` ASC) VISIBLE,
  CONSTRAINT `FK_Warehouse_Colors_Application_People`
    FOREIGN KEY (`LastEditedBy`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`colors_archive`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`colors_archive` (
  `ColorID` INT(11) NOT NULL,
  `ColorName` VARCHAR(20) NOT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `ValidFrom` DATETIME NOT NULL,
  `ValidTo` DATETIME NOT NULL,
  INDEX `ix_Colors_Archive` (`ValidFrom` ASC, `ValidTo` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`countries_archive`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`countries_archive` (
  `CountryID` INT(11) NOT NULL,
  `CountryName` VARCHAR(60) NOT NULL,
  `FormalName` VARCHAR(60) NOT NULL,
  `IsoAlpha3Code` VARCHAR(3) NULL DEFAULT NULL,
  `IsoNumericCode` INT(11) NULL DEFAULT NULL,
  `CountryType` VARCHAR(20) NULL DEFAULT NULL,
  `LatestRecordedPopulation` BIGINT(20) NULL DEFAULT NULL,
  `Continent` VARCHAR(30) NOT NULL,
  `Region` VARCHAR(30) NOT NULL,
  `Subregion` VARCHAR(30) NOT NULL,
  `Border` VARCHAR(100) NULL DEFAULT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `ValidFrom` DATETIME NOT NULL,
  `ValidTo` DATETIME NOT NULL,
  INDEX `ix_Countries_Archive` (`ValidFrom` ASC, `ValidTo` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`customercategories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`customercategories` (
  `CustomerCategoryID` INT(11) NOT NULL,
  `CustomerCategoryName` VARCHAR(50) NOT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `ValidFrom` DATETIME NOT NULL,
  `ValidTo` DATETIME NOT NULL,
  PRIMARY KEY (`CustomerCategoryID`),
  UNIQUE INDEX `UQ_Sales_CustomerCategories_CustomerCategoryName` (`CustomerCategoryName` ASC) VISIBLE,
  INDEX `FK_Sales_CustomerCategories_Application_People` (`LastEditedBy` ASC) VISIBLE,
  CONSTRAINT `FK_Sales_CustomerCategories_Application_People`
    FOREIGN KEY (`LastEditedBy`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`customercategories_archive`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`customercategories_archive` (
  `CustomerCategoryID` INT(11) NOT NULL,
  `CustomerCategoryName` VARCHAR(50) NOT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `ValidFrom` DATETIME NOT NULL,
  `ValidTo` DATETIME NOT NULL,
  INDEX `ix_CustomerCategories_Archive` (`ValidFrom` ASC, `ValidTo` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`deliverymethods`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`deliverymethods` (
  `DeliveryMethodID` INT(11) NOT NULL,
  `DeliveryMethodName` VARCHAR(50) NOT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `ValidFrom` DATETIME NOT NULL,
  `ValidTo` DATETIME NOT NULL,
  PRIMARY KEY (`DeliveryMethodID`),
  UNIQUE INDEX `UQ_Application_DeliveryMethods_DeliveryMethodName` (`DeliveryMethodName` ASC) VISIBLE,
  INDEX `FK_Application_DeliveryMethods_Application_People` (`LastEditedBy` ASC) VISIBLE,
  CONSTRAINT `FK_Application_DeliveryMethods_Application_People`
    FOREIGN KEY (`LastEditedBy`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`customers` (
  `CustomerID` INT(11) NOT NULL AUTO_INCREMENT,
  `CustomerName` VARCHAR(100) NOT NULL,
  `BillToCustomerID` INT(11) NOT NULL,
  `CustomerCategoryID` INT(11) NOT NULL,
  `BuyingGroupID` INT(11) NULL DEFAULT NULL,
  `PrimaryContactPersonID` INT(11) NOT NULL,
  `AlternateContactPersonID` INT(11) NULL DEFAULT NULL,
  `DeliveryMethodID` INT(11) NOT NULL,
  `DeliveryCityID` INT(11) NOT NULL,
  `PostalCityID` INT(11) NOT NULL,
  `CreditLimit` DECIMAL(18,2) NULL DEFAULT NULL,
  `AccountOpenedDate` DATE NOT NULL,
  `StandardDiscountPercentage` DECIMAL(18,3) NOT NULL,
  `IsStatementSent` TINYINT(1) NOT NULL,
  `IsOnCreditHold` TINYINT(1) NOT NULL,
  `PaymentDays` INT(11) NOT NULL,
  `PhoneNumber` VARCHAR(20) NOT NULL,
  `FaxNumber` VARCHAR(20) NOT NULL,
  `DeliveryRun` VARCHAR(5) NULL DEFAULT NULL,
  `RunPosition` VARCHAR(5) NULL DEFAULT NULL,
  `WebsiteURL` VARCHAR(256) NOT NULL,
  `DeliveryAddressLine1` VARCHAR(60) NOT NULL,
  `DeliveryAddressLine2` VARCHAR(60) NULL DEFAULT NULL,
  `DeliveryPostalCode` VARCHAR(10) NOT NULL,
  `DeliveryLocation` VARCHAR(100) NULL DEFAULT NULL,
  `PostalAddressLine1` VARCHAR(60) NOT NULL,
  `PostalAddressLine2` VARCHAR(60) NULL DEFAULT NULL,
  `PostalPostalCode` VARCHAR(10) NOT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `ValidFrom` DATETIME NOT NULL,
  `ValidTo` DATETIME NOT NULL,
  PRIMARY KEY (`CustomerID`),
  UNIQUE INDEX `UQ_Sales_Customers_CustomerName` (`CustomerName` ASC) VISIBLE,
  INDEX `FK_Sales_Customers_CustomerCategoryID` (`CustomerCategoryID` ASC) VISIBLE,
  INDEX `FK_Sales_Customers_BuyingGroupID` (`BuyingGroupID` ASC) VISIBLE,
  INDEX `FK_Sales_Customers_PrimaryContactPersonID` (`PrimaryContactPersonID` ASC) VISIBLE,
  INDEX `FK_Sales_Customers_AlternateContactPersonID` (`AlternateContactPersonID` ASC) VISIBLE,
  INDEX `FK_Sales_Customers_DeliveryMethodID` (`DeliveryMethodID` ASC) VISIBLE,
  INDEX `FK_Sales_Customers_DeliveryCityID` (`DeliveryCityID` ASC) VISIBLE,
  INDEX `FK_Sales_Customers_PostalCityID` (`PostalCityID` ASC) VISIBLE,
  INDEX `IX_Sales_Customers_Perf_20160301_06` (`IsOnCreditHold` ASC, `CustomerID` ASC, `BillToCustomerID` ASC, `PrimaryContactPersonID` ASC) VISIBLE,
  INDEX `FK_Sales_Customers_BillToCustomerID_Sales_Customers` (`BillToCustomerID` ASC) VISIBLE,
  INDEX `FK_Sales_Customers_Application_People` (`LastEditedBy` ASC) VISIBLE,
  CONSTRAINT `FK_Sales_Customers_AlternateContactPersonID_Application_People`
    FOREIGN KEY (`AlternateContactPersonID`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sales_Customers_Application_People`
    FOREIGN KEY (`LastEditedBy`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sales_Customers_BillToCustomerID_Sales_Customers`
    FOREIGN KEY (`BillToCustomerID`)
    REFERENCES `nerdygadgets`.`customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sales_Customers_BuyingGroupID_Sales_BuyingGroups`
    FOREIGN KEY (`BuyingGroupID`)
    REFERENCES `nerdygadgets`.`buyinggroups` (`BuyingGroupID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sales_Customers_CustomerCategoryID_Sales_CustomerCategories`
    FOREIGN KEY (`CustomerCategoryID`)
    REFERENCES `nerdygadgets`.`customercategories` (`CustomerCategoryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sales_Customers_DeliveryCityID_Application_Cities`
    FOREIGN KEY (`DeliveryCityID`)
    REFERENCES `nerdygadgets`.`cities` (`CityID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sales_Customers_DeliveryMethodID_Application_DeliveryMethods`
    FOREIGN KEY (`DeliveryMethodID`)
    REFERENCES `nerdygadgets`.`deliverymethods` (`DeliveryMethodID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sales_Customers_PostalCityID_Application_Cities`
    FOREIGN KEY (`PostalCityID`)
    REFERENCES `nerdygadgets`.`cities` (`CityID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sales_Customers_PrimaryContactPersonID_Application_People`
    FOREIGN KEY (`PrimaryContactPersonID`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1062
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`customers_archive`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`customers_archive` (
  `CustomerID` INT(11) NOT NULL,
  `CustomerName` VARCHAR(100) NOT NULL,
  `BillToCustomerID` INT(11) NOT NULL,
  `CustomerCategoryID` INT(11) NOT NULL,
  `BuyingGroupID` INT(11) NULL DEFAULT NULL,
  `PrimaryContactPersonID` INT(11) NOT NULL,
  `AlternateContactPersonID` INT(11) NULL DEFAULT NULL,
  `DeliveryMethodID` INT(11) NOT NULL,
  `DeliveryCityID` INT(11) NOT NULL,
  `PostalCityID` INT(11) NOT NULL,
  `CreditLimit` DECIMAL(18,2) NULL DEFAULT NULL,
  `AccountOpenedDate` DATE NOT NULL,
  `StandardDiscountPercentage` DECIMAL(18,3) NOT NULL,
  `IsStatementSent` TINYINT(1) NOT NULL,
  `IsOnCreditHold` TINYINT(1) NOT NULL,
  `PaymentDays` INT(11) NOT NULL,
  `PhoneNumber` VARCHAR(20) NOT NULL,
  `FaxNumber` VARCHAR(20) NOT NULL,
  `DeliveryRun` VARCHAR(5) NULL DEFAULT NULL,
  `RunPosition` VARCHAR(5) NULL DEFAULT NULL,
  `WebsiteURL` VARCHAR(256) NOT NULL,
  `DeliveryAddressLine1` VARCHAR(60) NOT NULL,
  `DeliveryAddressLine2` VARCHAR(60) NULL DEFAULT NULL,
  `DeliveryPostalCode` VARCHAR(10) NOT NULL,
  `DeliveryLocation` VARCHAR(100) NULL DEFAULT NULL,
  `PostalAddressLine1` VARCHAR(60) NOT NULL,
  `PostalAddressLine2` VARCHAR(60) NULL DEFAULT NULL,
  `PostalPostalCode` VARCHAR(10) NOT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `ValidFrom` DATETIME NOT NULL,
  `ValidTo` DATETIME NOT NULL,
  INDEX `ix_Customers_Archive` (`ValidFrom` ASC, `ValidTo` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`orders` (
  `OrderID` INT(11) NOT NULL AUTO_INCREMENT,
  `CustomerID` INT(11) NOT NULL,
  `SalespersonPersonID` INT(11) NOT NULL,
  `PickedByPersonID` INT(11) NULL DEFAULT NULL,
  `ContactPersonID` INT(11) NOT NULL,
  `BackorderOrderID` INT(11) NULL DEFAULT NULL,
  `OrderDate` DATE NOT NULL,
  `ExpectedDeliveryDate` DATE NOT NULL,
  `CustomerPurchaseOrderNumber` VARCHAR(20) NULL DEFAULT NULL,
  `IsUndersupplyBackordered` TINYINT(1) NOT NULL,
  `Comments` LONGTEXT NULL DEFAULT NULL,
  `DeliveryInstructions` LONGTEXT NULL DEFAULT NULL,
  `InternalComments` LONGTEXT NULL DEFAULT NULL,
  `PickingCompletedWhen` DATETIME NULL DEFAULT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `LastEditedWhen` DATETIME NOT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `FK_Sales_Orders_CustomerID` (`CustomerID` ASC) VISIBLE,
  INDEX `FK_Sales_Orders_SalespersonPersonID` (`SalespersonPersonID` ASC) VISIBLE,
  INDEX `FK_Sales_Orders_PickedByPersonID` (`PickedByPersonID` ASC) VISIBLE,
  INDEX `FK_Sales_Orders_ContactPersonID` (`ContactPersonID` ASC) VISIBLE,
  INDEX `FK_Sales_Orders_BackorderOrderID_Sales_Orders` (`BackorderOrderID` ASC) VISIBLE,
  INDEX `FK_Sales_Orders_Application_People` (`LastEditedBy` ASC) VISIBLE,
  CONSTRAINT `FK_Sales_Orders_Application_People`
    FOREIGN KEY (`LastEditedBy`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sales_Orders_BackorderOrderID_Sales_Orders`
    FOREIGN KEY (`BackorderOrderID`)
    REFERENCES `nerdygadgets`.`orders` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sales_Orders_ContactPersonID_Application_People`
    FOREIGN KEY (`ContactPersonID`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sales_Orders_CustomerID_Sales_Customers`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `nerdygadgets`.`customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sales_Orders_PickedByPersonID_Application_People`
    FOREIGN KEY (`PickedByPersonID`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sales_Orders_SalespersonPersonID_Application_People`
    FOREIGN KEY (`SalespersonPersonID`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 73596
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`invoices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`invoices` (
  `InvoiceID` INT(11) NOT NULL,
  `CustomerID` INT(11) NOT NULL,
  `BillToCustomerID` INT(11) NOT NULL,
  `OrderID` INT(11) NULL DEFAULT NULL,
  `DeliveryMethodID` INT(11) NOT NULL,
  `ContactPersonID` INT(11) NOT NULL,
  `AccountsPersonID` INT(11) NOT NULL,
  `SalespersonPersonID` INT(11) NOT NULL,
  `PackedByPersonID` INT(11) NOT NULL,
  `InvoiceDate` DATE NOT NULL,
  `CustomerPurchaseOrderNumber` VARCHAR(20) NULL DEFAULT NULL,
  `IsCreditNote` TINYINT(1) NOT NULL,
  `CreditNoteReason` LONGTEXT NULL DEFAULT NULL,
  `Comments` LONGTEXT NULL DEFAULT NULL,
  `DeliveryInstructions` LONGTEXT NULL DEFAULT NULL,
  `InternalComments` LONGTEXT NULL DEFAULT NULL,
  `TotalDryItems` INT(11) NOT NULL,
  `TotalChillerItems` INT(11) NOT NULL,
  `DeliveryRun` VARCHAR(5) NULL DEFAULT NULL,
  `RunPosition` VARCHAR(5) NULL DEFAULT NULL,
  `ReturnedDeliveryData` LONGTEXT NULL DEFAULT NULL,
  `ConfirmedDeliveryTime` DATETIME NULL DEFAULT NULL,
  `ConfirmedReceivedBy` VARCHAR(4000) NULL DEFAULT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `LastEditedWhen` DATETIME NOT NULL,
  PRIMARY KEY (`InvoiceID`),
  INDEX `FK_Sales_Invoices_CustomerID` (`CustomerID` ASC) VISIBLE,
  INDEX `FK_Sales_Invoices_BillToCustomerID` (`BillToCustomerID` ASC) VISIBLE,
  INDEX `FK_Sales_Invoices_OrderID` (`OrderID` ASC) VISIBLE,
  INDEX `FK_Sales_Invoices_DeliveryMethodID` (`DeliveryMethodID` ASC) VISIBLE,
  INDEX `FK_Sales_Invoices_ContactPersonID` (`ContactPersonID` ASC) VISIBLE,
  INDEX `FK_Sales_Invoices_AccountsPersonID` (`AccountsPersonID` ASC) VISIBLE,
  INDEX `FK_Sales_Invoices_SalespersonPersonID` (`SalespersonPersonID` ASC) VISIBLE,
  INDEX `FK_Sales_Invoices_PackedByPersonID` (`PackedByPersonID` ASC) VISIBLE,
  INDEX `IX_Sales_Invoices_ConfirmedDeliveryTime` (`ConfirmedDeliveryTime` ASC, `ConfirmedReceivedBy`(255) ASC) VISIBLE,
  INDEX `FK_Sales_Invoices_Application_People` (`LastEditedBy` ASC) VISIBLE,
  CONSTRAINT `FK_Sales_Invoices_AccountsPersonID_Application_People`
    FOREIGN KEY (`AccountsPersonID`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sales_Invoices_Application_People`
    FOREIGN KEY (`LastEditedBy`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sales_Invoices_BillToCustomerID_Sales_Customers`
    FOREIGN KEY (`BillToCustomerID`)
    REFERENCES `nerdygadgets`.`customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sales_Invoices_ContactPersonID_Application_People`
    FOREIGN KEY (`ContactPersonID`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sales_Invoices_CustomerID_Sales_Customers`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `nerdygadgets`.`customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sales_Invoices_DeliveryMethodID_Application_DeliveryMethods`
    FOREIGN KEY (`DeliveryMethodID`)
    REFERENCES `nerdygadgets`.`deliverymethods` (`DeliveryMethodID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sales_Invoices_OrderID_Sales_Orders`
    FOREIGN KEY (`OrderID`)
    REFERENCES `nerdygadgets`.`orders` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sales_Invoices_PackedByPersonID_Application_People`
    FOREIGN KEY (`PackedByPersonID`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sales_Invoices_SalespersonPersonID_Application_People`
    FOREIGN KEY (`SalespersonPersonID`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`paymentmethods`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`paymentmethods` (
  `PaymentMethodID` INT(11) NOT NULL,
  `PaymentMethodName` VARCHAR(50) NOT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `ValidFrom` DATETIME NOT NULL,
  `ValidTo` DATETIME NOT NULL,
  PRIMARY KEY (`PaymentMethodID`),
  UNIQUE INDEX `UQ_Application_PaymentMethods_PaymentMethodName` (`PaymentMethodName` ASC) VISIBLE,
  INDEX `FK_Application_PaymentMethods_Application_People` (`LastEditedBy` ASC) VISIBLE,
  CONSTRAINT `FK_Application_PaymentMethods_Application_People`
    FOREIGN KEY (`LastEditedBy`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`transactiontypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`transactiontypes` (
  `TransactionTypeID` INT(11) NOT NULL,
  `TransactionTypeName` VARCHAR(50) NOT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `ValidFrom` DATETIME NOT NULL,
  `ValidTo` DATETIME NOT NULL,
  PRIMARY KEY (`TransactionTypeID`),
  UNIQUE INDEX `UQ_Application_TransactionTypes_TransactionTypeName` (`TransactionTypeName` ASC) VISIBLE,
  INDEX `FK_Application_TransactionTypes_Application_People` (`LastEditedBy` ASC) VISIBLE,
  CONSTRAINT `FK_Application_TransactionTypes_Application_People`
    FOREIGN KEY (`LastEditedBy`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`customertransactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`customertransactions` (
  `CustomerTransactionID` INT(11) NOT NULL,
  `CustomerID` INT(11) NOT NULL,
  `TransactionTypeID` INT(11) NOT NULL,
  `InvoiceID` INT(11) NULL DEFAULT NULL,
  `PaymentMethodID` INT(11) NULL DEFAULT NULL,
  `TransactionDate` DATE NOT NULL,
  `AmountExcludingTax` DECIMAL(18,2) NOT NULL,
  `TaxAmount` DECIMAL(18,2) NOT NULL,
  `TransactionAmount` DECIMAL(18,2) NOT NULL,
  `OutstandingBalance` DECIMAL(18,2) NOT NULL,
  `FinalizationDate` DATE NULL DEFAULT NULL,
  `IsFinalized` TINYINT(1) NULL DEFAULT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `LastEditedWhen` DATETIME NOT NULL,
  PRIMARY KEY (`CustomerTransactionID`),
  INDEX `CX_Sales_CustomerTransactions` (`TransactionDate` ASC) VISIBLE,
  INDEX `FK_Sales_CustomerTransactions_CustomerID` (`CustomerID` ASC, `TransactionDate` ASC) VISIBLE,
  INDEX `FK_Sales_CustomerTransactions_TransactionTypeID` (`TransactionTypeID` ASC, `TransactionDate` ASC) VISIBLE,
  INDEX `FK_Sales_CustomerTransactions_InvoiceID` (`InvoiceID` ASC, `TransactionDate` ASC) VISIBLE,
  INDEX `FK_Sales_CustomerTransactions_PaymentMethodID` (`PaymentMethodID` ASC, `TransactionDate` ASC) VISIBLE,
  INDEX `IX_Sales_CustomerTransactions_IsFinalized` (`IsFinalized` ASC, `TransactionDate` ASC) VISIBLE,
  INDEX `FK_Sales_CustomerTransactions_Application_People` (`LastEditedBy` ASC) VISIBLE,
  CONSTRAINT `FK_Sales_CustomerTransactions_Application_People`
    FOREIGN KEY (`LastEditedBy`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sales_CustomerTransactions_CustomerID_Sales_Customers`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `nerdygadgets`.`customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sales_CustomerTransactions_InvoiceID_Sales_Invoices`
    FOREIGN KEY (`InvoiceID`)
    REFERENCES `nerdygadgets`.`invoices` (`InvoiceID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sales_CustomerTransactions_PaymentMethodID_Application_Paym15`
    FOREIGN KEY (`PaymentMethodID`)
    REFERENCES `nerdygadgets`.`paymentmethods` (`PaymentMethodID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sales_CustomerTransactions_TransactionTypeID_Application_Tr14`
    FOREIGN KEY (`TransactionTypeID`)
    REFERENCES `nerdygadgets`.`transactiontypes` (`TransactionTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`deliverymethods_archive`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`deliverymethods_archive` (
  `DeliveryMethodID` INT(11) NOT NULL,
  `DeliveryMethodName` VARCHAR(50) NOT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `ValidFrom` DATETIME NOT NULL,
  `ValidTo` DATETIME NOT NULL,
  INDEX `ix_DeliveryMethods_Archive` (`ValidFrom` ASC, `ValidTo` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`packagetypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`packagetypes` (
  `PackageTypeID` INT(11) NOT NULL,
  `PackageTypeName` VARCHAR(50) NOT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `ValidFrom` DATETIME NOT NULL,
  `ValidTo` DATETIME NOT NULL,
  PRIMARY KEY (`PackageTypeID`),
  UNIQUE INDEX `UQ_Warehouse_PackageTypes_PackageTypeName` (`PackageTypeName` ASC) VISIBLE,
  INDEX `FK_Warehouse_PackageTypes_Application_People` (`LastEditedBy` ASC) VISIBLE,
  CONSTRAINT `FK_Warehouse_PackageTypes_Application_People`
    FOREIGN KEY (`LastEditedBy`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`suppliercategories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`suppliercategories` (
  `SupplierCategoryID` INT(11) NOT NULL,
  `SupplierCategoryName` VARCHAR(50) NOT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `ValidFrom` DATETIME NOT NULL,
  `ValidTo` DATETIME NOT NULL,
  PRIMARY KEY (`SupplierCategoryID`),
  UNIQUE INDEX `UQ_Purchasing_SupplierCategories_SupplierCategoryName` (`SupplierCategoryName` ASC) VISIBLE,
  INDEX `FK_Purchasing_SupplierCategories_Application_People` (`LastEditedBy` ASC) VISIBLE,
  CONSTRAINT `FK_Purchasing_SupplierCategories_Application_People`
    FOREIGN KEY (`LastEditedBy`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`suppliers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`suppliers` (
  `SupplierID` INT(11) NOT NULL,
  `SupplierName` VARCHAR(100) NOT NULL,
  `SupplierCategoryID` INT(11) NOT NULL,
  `PrimaryContactPersonID` INT(11) NOT NULL,
  `AlternateContactPersonID` INT(11) NOT NULL,
  `DeliveryMethodID` INT(11) NULL DEFAULT NULL,
  `DeliveryCityID` INT(11) NOT NULL,
  `PostalCityID` INT(11) NOT NULL,
  `SupplierReference` VARCHAR(20) NULL DEFAULT NULL,
  `BankAccountName` VARCHAR(50) NULL DEFAULT NULL,
  `BankAccountBranch` VARCHAR(50) NULL DEFAULT NULL,
  `BankAccountCode` VARCHAR(20) NULL DEFAULT NULL,
  `BankAccountNumber` VARCHAR(20) NULL DEFAULT NULL,
  `BankInternationalCode` VARCHAR(20) NULL DEFAULT NULL,
  `PaymentDays` INT(11) NOT NULL,
  `InternalComments` LONGTEXT NULL DEFAULT NULL,
  `PhoneNumber` VARCHAR(20) NOT NULL,
  `FaxNumber` VARCHAR(20) NOT NULL,
  `WebsiteURL` VARCHAR(256) NOT NULL,
  `DeliveryAddressLine1` VARCHAR(60) NOT NULL,
  `DeliveryAddressLine2` VARCHAR(60) NULL DEFAULT NULL,
  `DeliveryPostalCode` VARCHAR(10) NOT NULL,
  `DeliveryLocation` VARCHAR(100) NULL DEFAULT NULL,
  `PostalAddressLine1` VARCHAR(60) NOT NULL,
  `PostalAddressLine2` VARCHAR(60) NULL DEFAULT NULL,
  `PostalPostalCode` VARCHAR(10) NOT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `ValidFrom` DATETIME NOT NULL,
  `ValidTo` DATETIME NOT NULL,
  PRIMARY KEY (`SupplierID`),
  UNIQUE INDEX `UQ_Purchasing_Suppliers_SupplierName` (`SupplierName` ASC) VISIBLE,
  INDEX `FK_Purchasing_Suppliers_SupplierCategoryID` (`SupplierCategoryID` ASC) VISIBLE,
  INDEX `FK_Purchasing_Suppliers_PrimaryContactPersonID` (`PrimaryContactPersonID` ASC) VISIBLE,
  INDEX `FK_Purchasing_Suppliers_AlternateContactPersonID` (`AlternateContactPersonID` ASC) VISIBLE,
  INDEX `FK_Purchasing_Suppliers_DeliveryMethodID` (`DeliveryMethodID` ASC) VISIBLE,
  INDEX `FK_Purchasing_Suppliers_DeliveryCityID` (`DeliveryCityID` ASC) VISIBLE,
  INDEX `FK_Purchasing_Suppliers_PostalCityID` (`PostalCityID` ASC) VISIBLE,
  INDEX `FK_Purchasing_Suppliers_Application_People` (`LastEditedBy` ASC) VISIBLE,
  CONSTRAINT `FK_Purchasing_Suppliers_AlternateContactPersonID_Application_P4`
    FOREIGN KEY (`AlternateContactPersonID`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Purchasing_Suppliers_Application_People`
    FOREIGN KEY (`LastEditedBy`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Purchasing_Suppliers_DeliveryCityID_Application_Cities`
    FOREIGN KEY (`DeliveryCityID`)
    REFERENCES `nerdygadgets`.`cities` (`CityID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Purchasing_Suppliers_DeliveryMethodID_Application_DeliveryM5`
    FOREIGN KEY (`DeliveryMethodID`)
    REFERENCES `nerdygadgets`.`deliverymethods` (`DeliveryMethodID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Purchasing_Suppliers_PostalCityID_Application_Cities`
    FOREIGN KEY (`PostalCityID`)
    REFERENCES `nerdygadgets`.`cities` (`CityID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Purchasing_Suppliers_PrimaryContactPersonID_Application_Peo3`
    FOREIGN KEY (`PrimaryContactPersonID`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Purchasing_Suppliers_SupplierCategoryID_Purchasing_Supplier2`
    FOREIGN KEY (`SupplierCategoryID`)
    REFERENCES `nerdygadgets`.`suppliercategories` (`SupplierCategoryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`stockitems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`stockitems` (
  `StockItemID` INT(11) NOT NULL,
  `StockItemName` VARCHAR(100) NOT NULL,
  `SupplierID` INT(11) NOT NULL,
  `ColorID` INT(11) NULL DEFAULT NULL,
  `UnitPackageID` INT(11) NOT NULL,
  `OuterPackageID` INT(11) NOT NULL,
  `Brand` VARCHAR(50) NULL DEFAULT NULL,
  `Size` VARCHAR(20) NULL DEFAULT NULL,
  `LeadTimeDays` INT(11) NOT NULL,
  `QuantityPerOuter` INT(11) NOT NULL,
  `IsChillerStock` TINYINT(1) NOT NULL,
  `Barcode` VARCHAR(50) NULL DEFAULT NULL,
  `TaxRate` DECIMAL(18,3) NOT NULL,
  `UnitPrice` DECIMAL(18,2) NOT NULL,
  `RecommendedRetailPrice` DECIMAL(18,2) NULL DEFAULT NULL,
  `TypicalWeightPerUnit` DECIMAL(18,3) NOT NULL,
  `MarketingComments` LONGTEXT NULL DEFAULT NULL,
  `InternalComments` LONGTEXT NULL DEFAULT NULL,
  `CustomFields` LONGTEXT NULL DEFAULT NULL,
  `Tags` LONGTEXT NULL DEFAULT NULL,
  `SearchDetails` LONGTEXT NOT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `ValidFrom` DATETIME NOT NULL,
  `ValidTo` DATETIME NOT NULL,
  `Video` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`StockItemID`),
  UNIQUE INDEX `UQ_Warehouse_StockItems_StockItemName` (`StockItemName` ASC) VISIBLE,
  INDEX `FK_Warehouse_StockItems_SupplierID` (`SupplierID` ASC) VISIBLE,
  INDEX `FK_Warehouse_StockItems_ColorID` (`ColorID` ASC) VISIBLE,
  INDEX `FK_Warehouse_StockItems_UnitPackageID` (`UnitPackageID` ASC) VISIBLE,
  INDEX `FK_Warehouse_StockItems_OuterPackageID` (`OuterPackageID` ASC) VISIBLE,
  INDEX `FK_Warehouse_StockItems_Application_People` (`LastEditedBy` ASC) VISIBLE,
  FULLTEXT INDEX `zoekartikel` (`StockItemName`, `SearchDetails`, `MarketingComments`) VISIBLE,
  CONSTRAINT `FK_Warehouse_StockItems_Application_People`
    FOREIGN KEY (`LastEditedBy`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Warehouse_StockItems_ColorID_Warehouse_Colors`
    FOREIGN KEY (`ColorID`)
    REFERENCES `nerdygadgets`.`colors` (`ColorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Warehouse_StockItems_OuterPackageID_Warehouse_PackageTypes`
    FOREIGN KEY (`OuterPackageID`)
    REFERENCES `nerdygadgets`.`packagetypes` (`PackageTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Warehouse_StockItems_SupplierID_Purchasing_Suppliers`
    FOREIGN KEY (`SupplierID`)
    REFERENCES `nerdygadgets`.`suppliers` (`SupplierID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Warehouse_StockItems_UnitPackageID_Warehouse_PackageTypes`
    FOREIGN KEY (`UnitPackageID`)
    REFERENCES `nerdygadgets`.`packagetypes` (`PackageTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`invoicelines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`invoicelines` (
  `InvoiceLineID` INT(11) NOT NULL,
  `InvoiceID` INT(11) NOT NULL,
  `StockItemID` INT(11) NOT NULL,
  `Description` VARCHAR(100) NOT NULL,
  `PackageTypeID` INT(11) NOT NULL,
  `Quantity` INT(11) NOT NULL,
  `UnitPrice` DECIMAL(18,2) NULL DEFAULT NULL,
  `TaxRate` DECIMAL(18,3) NOT NULL,
  `TaxAmount` DECIMAL(18,2) NOT NULL,
  `LineProfit` DECIMAL(18,2) NOT NULL,
  `ExtendedPrice` DECIMAL(18,2) NOT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `LastEditedWhen` DATETIME NOT NULL,
  PRIMARY KEY (`InvoiceLineID`),
  INDEX `FK_Sales_InvoiceLines_InvoiceID` (`InvoiceID` ASC) VISIBLE,
  INDEX `FK_Sales_InvoiceLines_StockItemID` (`StockItemID` ASC) VISIBLE,
  INDEX `FK_Sales_InvoiceLines_PackageTypeID` (`PackageTypeID` ASC) VISIBLE,
  INDEX `NCCX_Sales_InvoiceLines` (`InvoiceID` ASC, `StockItemID` ASC, `Quantity` ASC, `UnitPrice` ASC, `LineProfit` ASC, `LastEditedWhen` ASC) VISIBLE,
  INDEX `FK_Sales_InvoiceLines_Application_People` (`LastEditedBy` ASC) VISIBLE,
  CONSTRAINT `FK_Sales_InvoiceLines_Application_People`
    FOREIGN KEY (`LastEditedBy`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sales_InvoiceLines_InvoiceID_Sales_Invoices`
    FOREIGN KEY (`InvoiceID`)
    REFERENCES `nerdygadgets`.`invoices` (`InvoiceID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sales_InvoiceLines_PackageTypeID_Warehouse_PackageTypes`
    FOREIGN KEY (`PackageTypeID`)
    REFERENCES `nerdygadgets`.`packagetypes` (`PackageTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sales_InvoiceLines_StockItemID_Warehouse_StockItems`
    FOREIGN KEY (`StockItemID`)
    REFERENCES `nerdygadgets`.`stockitems` (`StockItemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`klanten`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`klanten` (
  `KlantID` INT(11) NOT NULL,
  `Voornaam` VARCHAR(45) NOT NULL,
  `Achternaam` VARCHAR(45) NOT NULL,
  `Tussenvoegsel` VARCHAR(45) NULL DEFAULT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Woonplaats` VARCHAR(45) NOT NULL,
  `Postcode` VARCHAR(45) NOT NULL,
  `Straat` VARCHAR(100) NOT NULL,
  `Huisnummer` VARCHAR(45) NOT NULL,
  `Land` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`KlantID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`klantbestelling`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`klantbestelling` (
  `KlantID` INT(100) NOT NULL,
  `BestellingID` INT(100) NOT NULL,
  PRIMARY KEY (`KlantID`, `BestellingID`),
  INDEX `fk_klantbestelling_bestelling1_idx` (`BestellingID` ASC) VISIBLE,
  CONSTRAINT `fk_klantbestelling_klanten1`
    FOREIGN KEY (`KlantID`)
    REFERENCES `nerdygadgets`.`klanten` (`KlantID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_klantbestelling_bestelling1`
    FOREIGN KEY (`BestellingID`)
    REFERENCES `nerdygadgets`.`bestelling` (`BestellingID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`orderlines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`orderlines` (
  `OrderLineID` INT(11) NOT NULL AUTO_INCREMENT,
  `OrderID` INT(11) NOT NULL,
  `StockItemID` INT(11) NOT NULL,
  `Description` VARCHAR(100) NOT NULL,
  `PackageTypeID` INT(11) NOT NULL,
  `Quantity` INT(11) NOT NULL,
  `UnitPrice` DECIMAL(18,2) NULL DEFAULT NULL,
  `TaxRate` DECIMAL(18,3) NOT NULL,
  `PickedQuantity` INT(11) NOT NULL,
  `PickingCompletedWhen` DATETIME NULL DEFAULT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `LastEditedWhen` DATETIME NOT NULL,
  PRIMARY KEY (`OrderLineID`),
  INDEX `FK_Sales_OrderLines_OrderID` (`OrderID` ASC) VISIBLE,
  INDEX `FK_Sales_OrderLines_PackageTypeID` (`PackageTypeID` ASC) VISIBLE,
  INDEX `IX_Sales_OrderLines_AllocatedStockItems` (`StockItemID` ASC, `PickedQuantity` ASC) VISIBLE,
  INDEX `IX_Sales_OrderLines_Perf_20160301_01` (`PickingCompletedWhen` ASC, `OrderID` ASC, `OrderLineID` ASC, `Quantity` ASC, `StockItemID` ASC) VISIBLE,
  INDEX `IX_Sales_OrderLines_Perf_20160301_02` (`StockItemID` ASC, `PickingCompletedWhen` ASC, `OrderID` ASC, `PickedQuantity` ASC) VISIBLE,
  INDEX `NCCX_Sales_OrderLines` (`OrderID` ASC, `StockItemID` ASC, `Description` ASC, `Quantity` ASC, `UnitPrice` ASC, `PickedQuantity` ASC) VISIBLE,
  INDEX `FK_Sales_OrderLines_Application_People` (`LastEditedBy` ASC) VISIBLE,
  CONSTRAINT `FK_Sales_OrderLines_Application_People`
    FOREIGN KEY (`LastEditedBy`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sales_OrderLines_OrderID_Sales_Orders`
    FOREIGN KEY (`OrderID`)
    REFERENCES `nerdygadgets`.`orders` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sales_OrderLines_PackageTypeID_Warehouse_PackageTypes`
    FOREIGN KEY (`PackageTypeID`)
    REFERENCES `nerdygadgets`.`packagetypes` (`PackageTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sales_OrderLines_StockItemID_Warehouse_StockItems`
    FOREIGN KEY (`StockItemID`)
    REFERENCES `nerdygadgets`.`stockitems` (`StockItemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 231413
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`packagetypes_archive`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`packagetypes_archive` (
  `PackageTypeID` INT(11) NOT NULL,
  `PackageTypeName` VARCHAR(50) NOT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `ValidFrom` DATETIME NOT NULL,
  `ValidTo` DATETIME NOT NULL,
  INDEX `ix_PackageTypes_Archive` (`ValidFrom` ASC, `ValidTo` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`paymentmethods_archive`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`paymentmethods_archive` (
  `PaymentMethodID` INT(11) NOT NULL,
  `PaymentMethodName` VARCHAR(50) NOT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `ValidFrom` DATETIME NOT NULL,
  `ValidTo` DATETIME NOT NULL,
  INDEX `ix_PaymentMethods_Archive` (`ValidFrom` ASC, `ValidTo` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`people_archive`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`people_archive` (
  `PersonID` INT(11) NOT NULL,
  `FullName` VARCHAR(50) NOT NULL,
  `PreferredName` VARCHAR(50) NOT NULL,
  `SearchName` VARCHAR(101) NOT NULL,
  `IsPermittedToLogon` TINYINT(1) NOT NULL,
  `LogonName` VARCHAR(50) NULL DEFAULT NULL,
  `IsExternalLogonProvider` TINYINT(1) NOT NULL,
  `HashedPassword` LONGBLOB NULL DEFAULT NULL,
  `IsSystemUser` TINYINT(1) NOT NULL,
  `IsEmployee` TINYINT(1) NOT NULL,
  `IsSalesperson` TINYINT(1) NOT NULL,
  `UserPreferences` LONGTEXT NULL DEFAULT NULL,
  `PhoneNumber` VARCHAR(20) NULL DEFAULT NULL,
  `FaxNumber` VARCHAR(20) NULL DEFAULT NULL,
  `EmailAddress` VARCHAR(256) NULL DEFAULT NULL,
  `Photo` LONGBLOB NULL DEFAULT NULL,
  `CustomFields` LONGTEXT NULL DEFAULT NULL,
  `OtherLanguages` LONGTEXT NULL DEFAULT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `ValidFrom` DATETIME NOT NULL,
  `ValidTo` DATETIME NOT NULL,
  INDEX `ix_People_Archive` (`ValidFrom` ASC, `ValidTo` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`purchaseorders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`purchaseorders` (
  `PurchaseOrderID` INT(11) NOT NULL,
  `SupplierID` INT(11) NOT NULL,
  `OrderDate` DATE NOT NULL,
  `DeliveryMethodID` INT(11) NOT NULL,
  `ContactPersonID` INT(11) NOT NULL,
  `ExpectedDeliveryDate` DATE NULL DEFAULT NULL,
  `SupplierReference` VARCHAR(20) NULL DEFAULT NULL,
  `IsOrderFinalized` TINYINT(1) NOT NULL,
  `Comments` LONGTEXT NULL DEFAULT NULL,
  `InternalComments` LONGTEXT NULL DEFAULT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `LastEditedWhen` DATETIME NOT NULL,
  PRIMARY KEY (`PurchaseOrderID`),
  INDEX `FK_Purchasing_PurchaseOrders_SupplierID` (`SupplierID` ASC) VISIBLE,
  INDEX `FK_Purchasing_PurchaseOrders_DeliveryMethodID` (`DeliveryMethodID` ASC) VISIBLE,
  INDEX `FK_Purchasing_PurchaseOrders_ContactPersonID` (`ContactPersonID` ASC) VISIBLE,
  INDEX `FK_Purchasing_PurchaseOrders_Application_People` (`LastEditedBy` ASC) VISIBLE,
  CONSTRAINT `FK_Purchasing_PurchaseOrders_Application_People`
    FOREIGN KEY (`LastEditedBy`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Purchasing_PurchaseOrders_ContactPersonID_Application_People`
    FOREIGN KEY (`ContactPersonID`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Purchasing_PurchaseOrders_DeliveryMethodID_Application_Deli6`
    FOREIGN KEY (`DeliveryMethodID`)
    REFERENCES `nerdygadgets`.`deliverymethods` (`DeliveryMethodID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Purchasing_PurchaseOrders_SupplierID_Purchasing_Suppliers`
    FOREIGN KEY (`SupplierID`)
    REFERENCES `nerdygadgets`.`suppliers` (`SupplierID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`purchaseorderlines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`purchaseorderlines` (
  `PurchaseOrderLineID` INT(11) NOT NULL,
  `PurchaseOrderID` INT(11) NOT NULL,
  `StockItemID` INT(11) NOT NULL,
  `OrderedOuters` INT(11) NOT NULL,
  `Description` VARCHAR(100) NOT NULL,
  `ReceivedOuters` INT(11) NOT NULL,
  `PackageTypeID` INT(11) NOT NULL,
  `ExpectedUnitPricePerOuter` DECIMAL(18,2) NULL DEFAULT NULL,
  `LastReceiptDate` DATE NULL DEFAULT NULL,
  `IsOrderLineFinalized` TINYINT(1) NOT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `LastEditedWhen` DATETIME NOT NULL,
  PRIMARY KEY (`PurchaseOrderLineID`),
  INDEX `FK_Purchasing_PurchaseOrderLines_PurchaseOrderID` (`PurchaseOrderID` ASC) VISIBLE,
  INDEX `FK_Purchasing_PurchaseOrderLines_StockItemID` (`StockItemID` ASC) VISIBLE,
  INDEX `FK_Purchasing_PurchaseOrderLines_PackageTypeID` (`PackageTypeID` ASC) VISIBLE,
  INDEX `IX_Purchasing_PurchaseOrderLines_Perf_20160301_4` (`IsOrderLineFinalized` ASC, `StockItemID` ASC, `OrderedOuters` ASC, `ReceivedOuters` ASC) VISIBLE,
  INDEX `FK_Purchasing_PurchaseOrderLines_Application_People` (`LastEditedBy` ASC) VISIBLE,
  CONSTRAINT `FK_Purchasing_PurchaseOrderLines_Application_People`
    FOREIGN KEY (`LastEditedBy`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Purchasing_PurchaseOrderLines_PackageTypeID_Warehouse_Packa9`
    FOREIGN KEY (`PackageTypeID`)
    REFERENCES `nerdygadgets`.`packagetypes` (`PackageTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Purchasing_PurchaseOrderLines_PurchaseOrderID_Purchasing_Pu7`
    FOREIGN KEY (`PurchaseOrderID`)
    REFERENCES `nerdygadgets`.`purchaseorders` (`PurchaseOrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Purchasing_PurchaseOrderLines_StockItemID_Warehouse_StockIt8`
    FOREIGN KEY (`StockItemID`)
    REFERENCES `nerdygadgets`.`stockitems` (`StockItemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`stockgroups`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`stockgroups` (
  `StockGroupID` INT(11) NOT NULL,
  `StockGroupName` VARCHAR(50) NOT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `ValidFrom` DATETIME NOT NULL,
  `ValidTo` DATETIME NOT NULL,
  `ImagePath` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`StockGroupID`),
  UNIQUE INDEX `UQ_Warehouse_StockGroups_StockGroupName` (`StockGroupName` ASC) VISIBLE,
  INDEX `FK_Warehouse_StockGroups_Application_People` (`LastEditedBy` ASC) VISIBLE,
  CONSTRAINT `FK_Warehouse_StockGroups_Application_People`
    FOREIGN KEY (`LastEditedBy`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`specialdeals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`specialdeals` (
  `SpecialDealID` INT(11) NOT NULL,
  `StockItemID` INT(11) NULL DEFAULT NULL,
  `CustomerID` INT(11) NULL DEFAULT NULL,
  `BuyingGroupID` INT(11) NULL DEFAULT NULL,
  `CustomerCategoryID` INT(11) NULL DEFAULT NULL,
  `StockGroupID` INT(11) NULL DEFAULT NULL,
  `DealDescription` VARCHAR(30) NOT NULL,
  `StartDate` DATE NOT NULL,
  `EndDate` DATE NOT NULL,
  `DiscountAmount` DECIMAL(18,2) NULL DEFAULT NULL,
  `DiscountPercentage` DECIMAL(18,3) NULL DEFAULT NULL,
  `UnitPrice` DECIMAL(18,2) NULL DEFAULT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `LastEditedWhen` DATETIME NOT NULL,
  PRIMARY KEY (`SpecialDealID`),
  INDEX `FK_Sales_SpecialDeals_StockItemID` (`StockItemID` ASC) VISIBLE,
  INDEX `FK_Sales_SpecialDeals_CustomerID` (`CustomerID` ASC) VISIBLE,
  INDEX `FK_Sales_SpecialDeals_BuyingGroupID` (`BuyingGroupID` ASC) VISIBLE,
  INDEX `FK_Sales_SpecialDeals_CustomerCategoryID` (`CustomerCategoryID` ASC) VISIBLE,
  INDEX `FK_Sales_SpecialDeals_StockGroupID` (`StockGroupID` ASC) VISIBLE,
  INDEX `FK_Sales_SpecialDeals_Application_People` (`LastEditedBy` ASC) VISIBLE,
  CONSTRAINT `FK_Sales_SpecialDeals_Application_People`
    FOREIGN KEY (`LastEditedBy`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sales_SpecialDeals_BuyingGroupID_Sales_BuyingGroups`
    FOREIGN KEY (`BuyingGroupID`)
    REFERENCES `nerdygadgets`.`buyinggroups` (`BuyingGroupID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sales_SpecialDeals_CustomerCategoryID_Sales_CustomerCategor16`
    FOREIGN KEY (`CustomerCategoryID`)
    REFERENCES `nerdygadgets`.`customercategories` (`CustomerCategoryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sales_SpecialDeals_CustomerID_Sales_Customers`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `nerdygadgets`.`customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sales_SpecialDeals_StockGroupID_Warehouse_StockGroups`
    FOREIGN KEY (`StockGroupID`)
    REFERENCES `nerdygadgets`.`stockgroups` (`StockGroupID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Sales_SpecialDeals_StockItemID_Warehouse_StockItems`
    FOREIGN KEY (`StockItemID`)
    REFERENCES `nerdygadgets`.`stockitems` (`StockItemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`stateprovinces_archive`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`stateprovinces_archive` (
  `StateProvinceID` INT(11) NOT NULL,
  `StateProvinceCode` VARCHAR(5) NOT NULL,
  `StateProvinceName` VARCHAR(50) NOT NULL,
  `CountryID` INT(11) NOT NULL,
  `SalesTerritory` VARCHAR(50) NOT NULL,
  `Border` VARCHAR(100) NULL DEFAULT NULL,
  `LatestRecordedPopulation` BIGINT(20) NULL DEFAULT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `ValidFrom` DATETIME NOT NULL,
  `ValidTo` DATETIME NOT NULL,
  INDEX `ix_StateProvinces_Archive` (`ValidFrom` ASC, `ValidTo` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`stockgroups_archive`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`stockgroups_archive` (
  `StockGroupID` INT(11) NOT NULL,
  `StockGroupName` VARCHAR(50) NOT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `ValidFrom` DATETIME NOT NULL,
  `ValidTo` DATETIME NOT NULL,
  INDEX `ix_StockGroups_Archive` (`ValidFrom` ASC, `ValidTo` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`stockitemholdings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`stockitemholdings` (
  `StockItemID` INT(11) NOT NULL,
  `QuantityOnHand` INT(11) NOT NULL,
  `BinLocation` VARCHAR(20) NOT NULL,
  `LastStocktakeQuantity` INT(11) NOT NULL,
  `LastCostPrice` DECIMAL(18,2) NOT NULL,
  `ReorderLevel` INT(11) NOT NULL,
  `TargetStockLevel` INT(11) NOT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `LastEditedWhen` DATETIME NOT NULL,
  PRIMARY KEY (`StockItemID`),
  INDEX `FK_Warehouse_StockItemHoldings_Application_People` (`LastEditedBy` ASC) VISIBLE,
  CONSTRAINT `FK_Warehouse_StockItemHoldings_Application_People`
    FOREIGN KEY (`LastEditedBy`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `PKFK_Warehouse_StockItemHoldings_StockItemID_Warehouse_StockIt23`
    FOREIGN KEY (`StockItemID`)
    REFERENCES `nerdygadgets`.`stockitems` (`StockItemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`stockitemimages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`stockitemimages` (
  `StockItemID` INT(11) NOT NULL,
  `ImagePath` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`StockItemID`, `ImagePath`),
  CONSTRAINT `FK_stockitemimages_stockitems`
    FOREIGN KEY (`StockItemID`)
    REFERENCES `nerdygadgets`.`stockitems` (`StockItemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`stockitems_archive`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`stockitems_archive` (
  `StockItemID` INT(11) NOT NULL,
  `StockItemName` VARCHAR(100) NOT NULL,
  `SupplierID` INT(11) NOT NULL,
  `ColorID` INT(11) NULL DEFAULT NULL,
  `UnitPackageID` INT(11) NOT NULL,
  `OuterPackageID` INT(11) NOT NULL,
  `Brand` VARCHAR(50) NULL DEFAULT NULL,
  `Size` VARCHAR(20) NULL DEFAULT NULL,
  `LeadTimeDays` INT(11) NOT NULL,
  `QuantityPerOuter` INT(11) NOT NULL,
  `IsChillerStock` TINYINT(1) NOT NULL,
  `Barcode` VARCHAR(50) NULL DEFAULT NULL,
  `TaxRate` DECIMAL(18,3) NOT NULL,
  `UnitPrice` DECIMAL(18,2) NOT NULL,
  `RecommendedRetailPrice` DECIMAL(18,2) NULL DEFAULT NULL,
  `TypicalWeightPerUnit` DECIMAL(18,3) NOT NULL,
  `MarketingComments` LONGTEXT NULL DEFAULT NULL,
  `InternalComments` LONGTEXT NULL DEFAULT NULL,
  `Photo` LONGBLOB NULL DEFAULT NULL,
  `CustomFields` LONGTEXT NULL DEFAULT NULL,
  `Tags` LONGTEXT NULL DEFAULT NULL,
  `SearchDetails` LONGTEXT NOT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `ValidFrom` DATETIME NOT NULL,
  `ValidTo` DATETIME NOT NULL,
  INDEX `ix_StockItems_Archive` (`ValidFrom` ASC, `ValidTo` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`stockitemstockgroups`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`stockitemstockgroups` (
  `StockItemStockGroupID` INT(11) NOT NULL,
  `StockItemID` INT(11) NOT NULL,
  `StockGroupID` INT(11) NOT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `LastEditedWhen` DATETIME NOT NULL,
  PRIMARY KEY (`StockItemStockGroupID`),
  UNIQUE INDEX `UQ_StockItemStockGroups_StockItemID_Lookup` (`StockItemID` ASC, `StockGroupID` ASC) VISIBLE,
  UNIQUE INDEX `UQ_StockItemStockGroups_StockGroupID_Lookup` (`StockGroupID` ASC, `StockItemID` ASC) VISIBLE,
  INDEX `FK_Warehouse_StockItemStockGroups_Application_People` (`LastEditedBy` ASC) VISIBLE,
  CONSTRAINT `FK_Warehouse_StockItemStockGroups_Application_People`
    FOREIGN KEY (`LastEditedBy`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Warehouse_StockItemStockGroups_StockGroupID_Warehouse_Stock18`
    FOREIGN KEY (`StockGroupID`)
    REFERENCES `nerdygadgets`.`stockgroups` (`StockGroupID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Warehouse_StockItemStockGroups_StockItemID_Warehouse_StockI17`
    FOREIGN KEY (`StockItemID`)
    REFERENCES `nerdygadgets`.`stockitems` (`StockItemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`stockitemtransactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`stockitemtransactions` (
  `StockItemTransactionID` INT(11) NOT NULL,
  `StockItemID` INT(11) NOT NULL,
  `TransactionTypeID` INT(11) NOT NULL,
  `CustomerID` INT(11) NULL DEFAULT NULL,
  `InvoiceID` INT(11) NULL DEFAULT NULL,
  `SupplierID` INT(11) NULL DEFAULT NULL,
  `PurchaseOrderID` INT(11) NULL DEFAULT NULL,
  `TransactionOccurredWhen` DATETIME NOT NULL,
  `Quantity` DECIMAL(18,3) NOT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `LastEditedWhen` DATETIME NOT NULL,
  PRIMARY KEY (`StockItemTransactionID`),
  INDEX `CCX_Warehouse_StockItemTransactions` (`StockItemTransactionID` ASC, `StockItemID` ASC, `TransactionTypeID` ASC, `CustomerID` ASC, `InvoiceID` ASC, `SupplierID` ASC, `PurchaseOrderID` ASC, `TransactionOccurredWhen` ASC, `Quantity` ASC, `LastEditedBy` ASC, `LastEditedWhen` ASC) VISIBLE,
  INDEX `FK_Warehouse_StockItemTransactions_StockItemID` (`StockItemID` ASC) VISIBLE,
  INDEX `FK_Warehouse_StockItemTransactions_TransactionTypeID` (`TransactionTypeID` ASC) VISIBLE,
  INDEX `FK_Warehouse_StockItemTransactions_CustomerID` (`CustomerID` ASC) VISIBLE,
  INDEX `FK_Warehouse_StockItemTransactions_InvoiceID` (`InvoiceID` ASC) VISIBLE,
  INDEX `FK_Warehouse_StockItemTransactions_SupplierID` (`SupplierID` ASC) VISIBLE,
  INDEX `FK_Warehouse_StockItemTransactions_PurchaseOrderID` (`PurchaseOrderID` ASC) VISIBLE,
  INDEX `FK_Warehouse_StockItemTransactions_Application_People` (`LastEditedBy` ASC) VISIBLE,
  CONSTRAINT `FK_Warehouse_StockItemTransactions_Application_People`
    FOREIGN KEY (`LastEditedBy`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Warehouse_StockItemTransactions_CustomerID_Sales_Customers`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `nerdygadgets`.`customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Warehouse_StockItemTransactions_InvoiceID_Sales_Invoices`
    FOREIGN KEY (`InvoiceID`)
    REFERENCES `nerdygadgets`.`invoices` (`InvoiceID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Warehouse_StockItemTransactions_PurchaseOrderID_Purchasing_22`
    FOREIGN KEY (`PurchaseOrderID`)
    REFERENCES `nerdygadgets`.`purchaseorders` (`PurchaseOrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Warehouse_StockItemTransactions_StockItemID_Warehouse_Stock19`
    FOREIGN KEY (`StockItemID`)
    REFERENCES `nerdygadgets`.`stockitems` (`StockItemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Warehouse_StockItemTransactions_SupplierID_Purchasing_Suppl21`
    FOREIGN KEY (`SupplierID`)
    REFERENCES `nerdygadgets`.`suppliers` (`SupplierID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Warehouse_StockItemTransactions_TransactionTypeID_Applicati20`
    FOREIGN KEY (`TransactionTypeID`)
    REFERENCES `nerdygadgets`.`transactiontypes` (`TransactionTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`suppliercategories_archive`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`suppliercategories_archive` (
  `SupplierCategoryID` INT(11) NOT NULL,
  `SupplierCategoryName` VARCHAR(50) NOT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `ValidFrom` DATETIME NOT NULL,
  `ValidTo` DATETIME NOT NULL,
  INDEX `ix_SupplierCategories_Archive` (`ValidFrom` ASC, `ValidTo` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`suppliers_archive`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`suppliers_archive` (
  `SupplierID` INT(11) NOT NULL,
  `SupplierName` VARCHAR(100) NOT NULL,
  `SupplierCategoryID` INT(11) NOT NULL,
  `PrimaryContactPersonID` INT(11) NOT NULL,
  `AlternateContactPersonID` INT(11) NOT NULL,
  `DeliveryMethodID` INT(11) NULL DEFAULT NULL,
  `DeliveryCityID` INT(11) NOT NULL,
  `PostalCityID` INT(11) NOT NULL,
  `SupplierReference` VARCHAR(20) NULL DEFAULT NULL,
  `BankAccountName` VARCHAR(50) NULL DEFAULT NULL,
  `BankAccountBranch` VARCHAR(50) NULL DEFAULT NULL,
  `BankAccountCode` VARCHAR(20) NULL DEFAULT NULL,
  `BankAccountNumber` VARCHAR(20) NULL DEFAULT NULL,
  `BankInternationalCode` VARCHAR(20) NULL DEFAULT NULL,
  `PaymentDays` INT(11) NOT NULL,
  `InternalComments` LONGTEXT NULL DEFAULT NULL,
  `PhoneNumber` VARCHAR(20) NOT NULL,
  `FaxNumber` VARCHAR(20) NOT NULL,
  `WebsiteURL` VARCHAR(256) NOT NULL,
  `DeliveryAddressLine1` VARCHAR(60) NOT NULL,
  `DeliveryAddressLine2` VARCHAR(60) NULL DEFAULT NULL,
  `DeliveryPostalCode` VARCHAR(10) NOT NULL,
  `DeliveryLocation` VARCHAR(100) NULL DEFAULT NULL,
  `PostalAddressLine1` VARCHAR(60) NOT NULL,
  `PostalAddressLine2` VARCHAR(60) NULL DEFAULT NULL,
  `PostalPostalCode` VARCHAR(10) NOT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `ValidFrom` DATETIME NOT NULL,
  `ValidTo` DATETIME NOT NULL,
  INDEX `ix_Suppliers_Archive` (`ValidFrom` ASC, `ValidTo` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`suppliertransactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`suppliertransactions` (
  `SupplierTransactionID` INT(11) NOT NULL,
  `SupplierID` INT(11) NOT NULL,
  `TransactionTypeID` INT(11) NOT NULL,
  `PurchaseOrderID` INT(11) NULL DEFAULT NULL,
  `PaymentMethodID` INT(11) NULL DEFAULT NULL,
  `SupplierInvoiceNumber` VARCHAR(20) NULL DEFAULT NULL,
  `TransactionDate` DATE NOT NULL,
  `AmountExcludingTax` DECIMAL(18,2) NOT NULL,
  `TaxAmount` DECIMAL(18,2) NOT NULL,
  `TransactionAmount` DECIMAL(18,2) NOT NULL,
  `OutstandingBalance` DECIMAL(18,2) NOT NULL,
  `FinalizationDate` DATE NULL DEFAULT NULL,
  `IsFinalized` TINYINT(1) NULL DEFAULT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `LastEditedWhen` DATETIME NOT NULL,
  PRIMARY KEY (`SupplierTransactionID`),
  INDEX `CX_Purchasing_SupplierTransactions` (`TransactionDate` ASC) VISIBLE,
  INDEX `FK_Purchasing_SupplierTransactions_SupplierID` (`SupplierID` ASC, `TransactionDate` ASC) VISIBLE,
  INDEX `FK_Purchasing_SupplierTransactions_TransactionTypeID` (`TransactionTypeID` ASC, `TransactionDate` ASC) VISIBLE,
  INDEX `FK_Purchasing_SupplierTransactions_PurchaseOrderID` (`PurchaseOrderID` ASC, `TransactionDate` ASC) VISIBLE,
  INDEX `FK_Purchasing_SupplierTransactions_PaymentMethodID` (`PaymentMethodID` ASC, `TransactionDate` ASC) VISIBLE,
  INDEX `IX_Purchasing_SupplierTransactions_IsFinalized` (`IsFinalized` ASC, `TransactionDate` ASC) VISIBLE,
  INDEX `FK_Purchasing_SupplierTransactions_Application_People` (`LastEditedBy` ASC) VISIBLE,
  CONSTRAINT `FK_Purchasing_SupplierTransactions_Application_People`
    FOREIGN KEY (`LastEditedBy`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Purchasing_SupplierTransactions_PaymentMethodID_Application13`
    FOREIGN KEY (`PaymentMethodID`)
    REFERENCES `nerdygadgets`.`paymentmethods` (`PaymentMethodID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Purchasing_SupplierTransactions_PurchaseOrderID_Purchasing_12`
    FOREIGN KEY (`PurchaseOrderID`)
    REFERENCES `nerdygadgets`.`purchaseorders` (`PurchaseOrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Purchasing_SupplierTransactions_SupplierID_Purchasing_Suppl10`
    FOREIGN KEY (`SupplierID`)
    REFERENCES `nerdygadgets`.`suppliers` (`SupplierID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Purchasing_SupplierTransactions_TransactionTypeID_Applicati11`
    FOREIGN KEY (`TransactionTypeID`)
    REFERENCES `nerdygadgets`.`transactiontypes` (`TransactionTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`sysdiagrams`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`sysdiagrams` (
  `name` VARCHAR(160) NOT NULL,
  `principal_id` INT(11) NOT NULL,
  `diagram_id` INT(11) NOT NULL AUTO_INCREMENT,
  `version` INT(11) NULL DEFAULT NULL,
  `definition` LONGBLOB NULL DEFAULT NULL,
  PRIMARY KEY (`diagram_id`),
  UNIQUE INDEX `UK_principal_name` (`principal_id` ASC, `name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`systemparameters`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`systemparameters` (
  `SystemParameterID` INT(11) NOT NULL,
  `DeliveryAddressLine1` VARCHAR(60) NOT NULL,
  `DeliveryAddressLine2` VARCHAR(60) NULL DEFAULT NULL,
  `DeliveryCityID` INT(11) NOT NULL,
  `DeliveryPostalCode` VARCHAR(10) NOT NULL,
  `DeliveryLocation` VARCHAR(100) NOT NULL,
  `PostalAddressLine1` VARCHAR(60) NOT NULL,
  `PostalAddressLine2` VARCHAR(60) NULL DEFAULT NULL,
  `PostalCityID` INT(11) NOT NULL,
  `PostalPostalCode` VARCHAR(10) NOT NULL,
  `ApplicationSettings` LONGTEXT NOT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `LastEditedWhen` DATETIME NOT NULL,
  PRIMARY KEY (`SystemParameterID`),
  INDEX `FK_Application_SystemParameters_DeliveryCityID` (`DeliveryCityID` ASC) VISIBLE,
  INDEX `FK_Application_SystemParameters_PostalCityID` (`PostalCityID` ASC) VISIBLE,
  INDEX `FK_Application_SystemParameters_Application_People` (`LastEditedBy` ASC) VISIBLE,
  CONSTRAINT `FK_Application_SystemParameters_Application_People`
    FOREIGN KEY (`LastEditedBy`)
    REFERENCES `nerdygadgets`.`people` (`PersonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Application_SystemParameters_DeliveryCityID_Application_Cit1`
    FOREIGN KEY (`DeliveryCityID`)
    REFERENCES `nerdygadgets`.`cities` (`CityID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Application_SystemParameters_PostalCityID_Application_Cities`
    FOREIGN KEY (`PostalCityID`)
    REFERENCES `nerdygadgets`.`cities` (`CityID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`transactiontypes_archive`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`transactiontypes_archive` (
  `TransactionTypeID` INT(11) NOT NULL,
  `TransactionTypeName` VARCHAR(50) NOT NULL,
  `LastEditedBy` INT(11) NOT NULL,
  `ValidFrom` DATETIME NOT NULL,
  `ValidTo` DATETIME NOT NULL,
  INDEX `ix_TransactionTypes_Archive` (`ValidFrom` ASC, `ValidTo` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `nerdygadgets`.`vehicletemperatures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `nerdygadgets`.`vehicletemperatures` (
  `VehicleTemperatureID` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `VehicleRegistration` VARCHAR(20) NOT NULL,
  `ChillerSensorNumber` INT(11) NOT NULL,
  `RecordedWhen` DATETIME NOT NULL,
  `Temperature` DECIMAL(10,2) NOT NULL,
  `FullSensorData` VARCHAR(1000) NULL DEFAULT NULL,
  `IsCompressed` TINYINT(1) NOT NULL,
  `CompressedSensorData` LONGBLOB NULL DEFAULT NULL,
  PRIMARY KEY (`VehicleTemperatureID`))
ENGINE = InnoDB
AUTO_INCREMENT = 65999
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
