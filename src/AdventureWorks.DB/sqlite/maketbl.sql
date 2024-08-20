-- Script Date: 8/18/2024 10:35 PM  - ErikEJ.SqlCeScripting version 3.5.2.95
SELECT 1;
PRAGMA foreign_keys=OFF;
CREATE TABLE [SpecialOffer] (
  [SpecialOfferID] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [Description] nvarchar(255) NOT NULL COLLATE NOCASE
, [DiscountPct] money DEFAULT (0.00) NOT NULL
, [Type] nvarchar(50) NOT NULL COLLATE NOCASE
, [Category] nvarchar(50) NOT NULL COLLATE NOCASE
, [StartDate] datetime NOT NULL
, [EndDate] datetime NOT NULL
, [MinQty] int DEFAULT (0) NOT NULL
, [MaxQty] int NULL
, [rowguid] uniqueidentifier NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
);
CREATE TABLE [SalesReason] (
  [SalesReasonID] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [Name] nvarchar(50) NOT NULL COLLATE NOCASE
, [ReasonType] nvarchar(50) NOT NULL COLLATE NOCASE
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
);
CREATE TABLE [Currency] (
  [CurrencyCode] nchar(3) NOT NULL
, [Name] nvarchar(50) NOT NULL COLLATE NOCASE
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [PK_Currency_CurrencyCode] PRIMARY KEY ([CurrencyCode])
);
CREATE TABLE [CurrencyRate] (
  [CurrencyRateID] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [CurrencyRateDate] datetime NOT NULL
, [FromCurrencyCode] nchar(3) NOT NULL COLLATE NOCASE
, [ToCurrencyCode] nchar(3) NOT NULL COLLATE NOCASE
, [AverageRate] money NOT NULL
, [EndOfDayRate] money NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [FK_CurrencyRate_Currency_FromCurrencyCode] FOREIGN KEY ([FromCurrencyCode]) REFERENCES [Currency] ([CurrencyCode]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_CurrencyRate_Currency_ToCurrencyCode] FOREIGN KEY ([ToCurrencyCode]) REFERENCES [Currency] ([CurrencyCode]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [CreditCard] (
  [CreditCardID] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [CardType] nvarchar(50) NOT NULL COLLATE NOCASE
, [CardNumber] nvarchar(25) NOT NULL COLLATE NOCASE
, [ExpMonth] tinyint NOT NULL
, [ExpYear] smallint NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
);
CREATE TABLE [ShipMethod] (
  [ShipMethodID] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [Name] nvarchar(50) NOT NULL COLLATE NOCASE
, [ShipBase] money DEFAULT (0.00) NOT NULL
, [ShipRate] money DEFAULT (0.00) NOT NULL
, [rowguid] uniqueidentifier NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
);
CREATE TABLE [UnitMeasure] (
  [UnitMeasureCode] nchar(3) NOT NULL
, [Name] nvarchar(50) NOT NULL COLLATE NOCASE
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [PK_UnitMeasure_UnitMeasureCode] PRIMARY KEY ([UnitMeasureCode])
);
CREATE TABLE [TransactionHistoryArchive] (
  [TransactionID] int NOT NULL
, [ProductID] int NOT NULL
, [ReferenceOrderID] int NOT NULL
, [ReferenceOrderLineID] int DEFAULT (0) NOT NULL
, [TransactionDate] datetime DEFAULT current_timestamp NOT NULL
, [TransactionType] nchar(1) NOT NULL COLLATE NOCASE
, [Quantity] int NOT NULL
, [ActualCost] money NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [PK_TransactionHistoryArchive_TransactionID] PRIMARY KEY ([TransactionID])
);
CREATE TABLE [ScrapReason] (
  [ScrapReasonID] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [Name] nvarchar(50) NOT NULL COLLATE NOCASE
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
);
CREATE TABLE [ProductPhoto] (
  [ProductPhotoID] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [ThumbNailPhoto] image NULL
, [ThumbnailPhotoFileName] nvarchar(50) NULL COLLATE NOCASE
, [LargePhoto] image NULL
, [LargePhotoFileName] nvarchar(50) NULL COLLATE NOCASE
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
);
CREATE TABLE [ProductModel] (
  [ProductModelID] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [Name] nvarchar(50) NOT NULL COLLATE NOCASE
, [CatalogDescription] ntext NULL
, [Instructions] ntext NULL
, [rowguid] uniqueidentifier NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
);
CREATE TABLE [ProductDescription] (
  [ProductDescriptionID] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [Description] nvarchar(400) NOT NULL COLLATE NOCASE
, [rowguid] uniqueidentifier NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
);
CREATE TABLE [ProductCategory] (
  [ProductCategoryID] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [Name] nvarchar(50) NOT NULL COLLATE NOCASE
, [rowguid] uniqueidentifier NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
);
CREATE TABLE [ProductSubcategory] (
  [ProductSubcategoryID] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [ProductCategoryID] int NOT NULL
, [Name] nvarchar(50) NOT NULL COLLATE NOCASE
, [rowguid] uniqueidentifier NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [FK_ProductSubcategory_ProductCategory_ProductCategoryID] FOREIGN KEY ([ProductCategoryID]) REFERENCES [ProductCategory] ([ProductCategoryID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [Product] (
  [ProductID] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [Name] nvarchar(50) NOT NULL COLLATE NOCASE
, [ProductNumber] nvarchar(25) NOT NULL COLLATE NOCASE
, [MakeFlag] bit DEFAULT (1) NOT NULL
, [FinishedGoodsFlag] bit DEFAULT (1) NOT NULL
, [Color] nvarchar(15) NULL COLLATE NOCASE
, [SafetyStockLevel] smallint NOT NULL
, [ReorderPoint] smallint NOT NULL
, [StandardCost] money NOT NULL
, [ListPrice] money NOT NULL
, [Size] nvarchar(5) NULL COLLATE NOCASE
, [SizeUnitMeasureCode] nchar(3) NULL COLLATE NOCASE
, [WeightUnitMeasureCode] nchar(3) NULL COLLATE NOCASE
, [Weight] numeric(8,2) NULL
, [DaysToManufacture] int NOT NULL
, [ProductLine] nchar(2) NULL COLLATE NOCASE
, [Class] nchar(2) NULL COLLATE NOCASE
, [Style] nchar(2) NULL COLLATE NOCASE
, [ProductSubcategoryID] int NULL
, [ProductModelID] int NULL
, [SellStartDate] datetime NOT NULL
, [SellEndDate] datetime NULL
, [DiscontinuedDate] datetime NULL
, [rowguid] uniqueidentifier NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [FK_Product_ProductModel_ProductModelID] FOREIGN KEY ([ProductModelID]) REFERENCES [ProductModel] ([ProductModelID]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_Product_ProductSubcategory_ProductSubcategoryID] FOREIGN KEY ([ProductSubcategoryID]) REFERENCES [ProductSubcategory] ([ProductSubcategoryID]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_Product_UnitMeasure_SizeUnitMeasureCode] FOREIGN KEY ([SizeUnitMeasureCode]) REFERENCES [UnitMeasure] ([UnitMeasureCode]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_Product_UnitMeasure_WeightUnitMeasureCode] FOREIGN KEY ([WeightUnitMeasureCode]) REFERENCES [UnitMeasure] ([UnitMeasureCode]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [WorkOrder] (
  [WorkOrderID] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [ProductID] int NOT NULL
, [OrderQty] int NOT NULL
, [ScrappedQty] smallint NOT NULL
, [StartDate] datetime NOT NULL
, [EndDate] datetime NULL
, [DueDate] datetime NOT NULL
, [ScrapReasonID] int NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [FK_WorkOrder_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Product] ([ProductID]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_WorkOrder_ScrapReason_ScrapReasonID] FOREIGN KEY ([ScrapReasonID]) REFERENCES [ScrapReason] ([ScrapReasonID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [TransactionHistory] (
  [TransactionID] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [ProductID] int NOT NULL
, [ReferenceOrderID] int NOT NULL
, [ReferenceOrderLineID] int DEFAULT (0) NOT NULL
, [TransactionDate] datetime DEFAULT current_timestamp NOT NULL
, [TransactionType] nchar(1) NOT NULL COLLATE NOCASE
, [Quantity] int NOT NULL
, [ActualCost] money NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [FK_TransactionHistory_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Product] ([ProductID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [SpecialOfferProduct] (
  [SpecialOfferID] int NOT NULL
, [ProductID] int NOT NULL
, [rowguid] uniqueidentifier NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [PK_SpecialOfferProduct_SpecialOfferID_ProductID] PRIMARY KEY ([SpecialOfferID],[ProductID])
, CONSTRAINT [FK_SpecialOfferProduct_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Product] ([ProductID]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_SpecialOfferProduct_SpecialOffer_SpecialOfferID] FOREIGN KEY ([SpecialOfferID]) REFERENCES [SpecialOffer] ([SpecialOfferID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [ShoppingCartItem] (
  [ShoppingCartItemID] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [ShoppingCartID] nvarchar(50) NOT NULL COLLATE NOCASE
, [Quantity] int DEFAULT (1) NOT NULL
, [ProductID] int NOT NULL
, [DateCreated] datetime DEFAULT current_timestamp NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [FK_ShoppingCartItem_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Product] ([ProductID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [ProductReview] (
  [ProductReviewID] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [ProductID] int NOT NULL
, [ReviewerName] nvarchar(50) NOT NULL COLLATE NOCASE
, [ReviewDate] datetime DEFAULT current_timestamp NOT NULL
, [EmailAddress] nvarchar(50) NOT NULL COLLATE NOCASE
, [Rating] int NOT NULL
, [Comments] nvarchar(3850) NULL COLLATE NOCASE
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [FK_ProductReview_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Product] ([ProductID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [ProductProductPhoto] (
  [ProductID] int NOT NULL
, [ProductPhotoID] int NOT NULL
, [Primary] bit DEFAULT (0) NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [PK_ProductProductPhoto_ProductID_ProductPhotoID] PRIMARY KEY ([ProductID],[ProductPhotoID])
, CONSTRAINT [FK_ProductProductPhoto_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Product] ([ProductID]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_ProductProductPhoto_ProductPhoto_ProductPhotoID] FOREIGN KEY ([ProductPhotoID]) REFERENCES [ProductPhoto] ([ProductPhotoID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [ProductListPriceHistory] (
  [ProductID] int NOT NULL
, [StartDate] datetime NOT NULL
, [EndDate] datetime NULL
, [ListPrice] money NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [PK_ProductListPriceHistory_ProductID_StartDate] PRIMARY KEY ([ProductID],[StartDate])
, CONSTRAINT [FK_ProductListPriceHistory_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Product] ([ProductID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [ProductCostHistory] (
  [ProductID] int NOT NULL
, [StartDate] datetime NOT NULL
, [EndDate] datetime NULL
, [StandardCost] money NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [PK_ProductCostHistory_ProductID_StartDate] PRIMARY KEY ([ProductID],[StartDate])
, CONSTRAINT [FK_ProductCostHistory_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Product] ([ProductID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [Location] (
  [LocationID] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [Name] nvarchar(50) NOT NULL COLLATE NOCASE
, [CostRate] money DEFAULT (0.00) NOT NULL
, [Availability] numeric(8,2) DEFAULT (0.00) NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
);
CREATE TABLE [WorkOrderRouting] (
  [WorkOrderID] int NOT NULL
, [ProductID] int NOT NULL
, [OperationSequence] smallint NOT NULL
, [LocationID] int NOT NULL
, [ScheduledStartDate] datetime NOT NULL
, [ScheduledEndDate] datetime NOT NULL
, [ActualStartDate] datetime NULL
, [ActualEndDate] datetime NULL
, [ActualResourceHrs] numeric(9,4) NULL
, [PlannedCost] money NOT NULL
, [ActualCost] money NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [PK_WorkOrderRouting_WorkOrderID_ProductID_OperationSequence] PRIMARY KEY ([WorkOrderID],[ProductID],[OperationSequence])
, CONSTRAINT [FK_WorkOrderRouting_Location_LocationID] FOREIGN KEY ([LocationID]) REFERENCES [Location] ([LocationID]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_WorkOrderRouting_WorkOrder_WorkOrderID] FOREIGN KEY ([WorkOrderID]) REFERENCES [WorkOrder] ([WorkOrderID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [ProductInventory] (
  [ProductID] int NOT NULL
, [LocationID] int NOT NULL
, [Shelf] nvarchar(10) NOT NULL COLLATE NOCASE
, [Bin] tinyint NOT NULL
, [Quantity] smallint DEFAULT (0) NOT NULL
, [rowguid] uniqueidentifier NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [PK_ProductInventory_ProductID_LocationID] PRIMARY KEY ([ProductID],[LocationID])
, CONSTRAINT [FK_ProductInventory_Location_LocationID] FOREIGN KEY ([LocationID]) REFERENCES [Location] ([LocationID]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_ProductInventory_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Product] ([ProductID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [Illustration] (
  [IllustrationID] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [Diagram] ntext NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
);
CREATE TABLE [ProductModelIllustration] (
  [ProductModelID] int NOT NULL
, [IllustrationID] int NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [PK_ProductModelIllustration_ProductModelID_IllustrationID] PRIMARY KEY ([ProductModelID],[IllustrationID])
, CONSTRAINT [FK_ProductModelIllustration_Illustration_IllustrationID] FOREIGN KEY ([IllustrationID]) REFERENCES [Illustration] ([IllustrationID]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_ProductModelIllustration_ProductModel_ProductModelID] FOREIGN KEY ([ProductModelID]) REFERENCES [ProductModel] ([ProductModelID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [Culture] (
  [CultureID] nchar(6) NOT NULL
, [Name] nvarchar(50) NOT NULL COLLATE NOCASE
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [PK_Culture_CultureID] PRIMARY KEY ([CultureID])
);
CREATE TABLE [ProductModelProductDescriptionCulture] (
  [ProductModelID] int NOT NULL
, [ProductDescriptionID] int NOT NULL
, [CultureID] nchar(6) NOT NULL COLLATE NOCASE
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [PK_ProductModelProductDescriptionCulture_ProductModelID_ProductDescriptionID_CultureID] PRIMARY KEY ([ProductModelID],[ProductDescriptionID],[CultureID])
, CONSTRAINT [FK_ProductModelProductDescriptionCulture_Culture_CultureID] FOREIGN KEY ([CultureID]) REFERENCES [Culture] ([CultureID]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_ProductModelProductDescriptionCulture_ProductDescription_ProductDescriptionID] FOREIGN KEY ([ProductDescriptionID]) REFERENCES [ProductDescription] ([ProductDescriptionID]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_ProductModelProductDescriptionCulture_ProductModel_ProductModelID] FOREIGN KEY ([ProductModelID]) REFERENCES [ProductModel] ([ProductModelID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [BillOfMaterials] (
  [BillOfMaterialsID] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [ProductAssemblyID] int NULL
, [ComponentID] int NOT NULL
, [StartDate] datetime DEFAULT current_timestamp NOT NULL
, [EndDate] datetime NULL
, [UnitMeasureCode] nchar(3) NOT NULL COLLATE NOCASE
, [BOMLevel] smallint NOT NULL
, [PerAssemblyQty] numeric(8,2) DEFAULT (1.00) NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [FK_BillOfMaterials_Product_ComponentID] FOREIGN KEY ([ComponentID]) REFERENCES [Product] ([ProductID]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_BillOfMaterials_Product_ProductAssemblyID] FOREIGN KEY ([ProductAssemblyID]) REFERENCES [Product] ([ProductID]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_BillOfMaterials_UnitMeasure_UnitMeasureCode] FOREIGN KEY ([UnitMeasureCode]) REFERENCES [UnitMeasure] ([UnitMeasureCode]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [PhoneNumberType] (
  [PhoneNumberTypeID] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [Name] nvarchar(50) NOT NULL COLLATE NOCASE
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
);
CREATE TABLE [CountryRegion] (
  [CountryRegionCode] nvarchar(3) NOT NULL
, [Name] nvarchar(50) NOT NULL COLLATE NOCASE
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [PK_CountryRegion_CountryRegionCode] PRIMARY KEY ([CountryRegionCode])
);
CREATE TABLE [SalesTerritory] (
  [TerritoryID] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [Name] nvarchar(50) NOT NULL COLLATE NOCASE
, [CountryRegionCode] nvarchar(3) NOT NULL COLLATE NOCASE
, [Group] nvarchar(50) NOT NULL COLLATE NOCASE
, [SalesYTD] money DEFAULT (0.00) NOT NULL
, [SalesLastYear] money DEFAULT (0.00) NOT NULL
, [CostYTD] money DEFAULT (0.00) NOT NULL
, [CostLastYear] money DEFAULT (0.00) NOT NULL
, [rowguid] uniqueidentifier NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [FK_SalesTerritory_CountryRegion_CountryRegionCode] FOREIGN KEY ([CountryRegionCode]) REFERENCES [CountryRegion] ([CountryRegionCode]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [StateProvince] (
  [StateProvinceID] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [StateProvinceCode] nchar(3) NOT NULL COLLATE NOCASE
, [CountryRegionCode] nvarchar(3) NOT NULL COLLATE NOCASE
, [IsOnlyStateProvinceFlag] bit DEFAULT (1) NOT NULL
, [Name] nvarchar(50) NOT NULL COLLATE NOCASE
, [TerritoryID] int NOT NULL
, [rowguid] uniqueidentifier NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [FK_StateProvince_CountryRegion_CountryRegionCode] FOREIGN KEY ([CountryRegionCode]) REFERENCES [CountryRegion] ([CountryRegionCode]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_StateProvince_SalesTerritory_TerritoryID] FOREIGN KEY ([TerritoryID]) REFERENCES [SalesTerritory] ([TerritoryID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [SalesTaxRate] (
  [SalesTaxRateID] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [StateProvinceID] int NOT NULL
, [TaxType] tinyint NOT NULL
, [TaxRate] money DEFAULT (0.00) NOT NULL
, [Name] nvarchar(50) NOT NULL COLLATE NOCASE
, [rowguid] uniqueidentifier NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [FK_SalesTaxRate_StateProvince_StateProvinceID] FOREIGN KEY ([StateProvinceID]) REFERENCES [StateProvince] ([StateProvinceID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [CountryRegionCurrency] (
  [CountryRegionCode] nvarchar(3) NOT NULL
, [CurrencyCode] nchar(3) NOT NULL COLLATE NOCASE
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode] PRIMARY KEY ([CountryRegionCode],[CurrencyCode])
, CONSTRAINT [FK_CountryRegionCurrency_CountryRegion_CountryRegionCode] FOREIGN KEY ([CountryRegionCode]) REFERENCES [CountryRegion] ([CountryRegionCode]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_CountryRegionCurrency_Currency_CurrencyCode] FOREIGN KEY ([CurrencyCode]) REFERENCES [Currency] ([CurrencyCode]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [ContactType] (
  [ContactTypeID] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [Name] nvarchar(50) NOT NULL COLLATE NOCASE
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
);
CREATE TABLE [BusinessEntity] (
  [BusinessEntityID] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [rowguid] uniqueidentifier NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
);
CREATE TABLE [Vendor] (
  [BusinessEntityID] int NOT NULL
, [AccountNumber] nvarchar(15) NOT NULL COLLATE NOCASE
, [Name] nvarchar(50) NOT NULL COLLATE NOCASE
, [CreditRating] tinyint NOT NULL
, [PreferredVendorStatus] bit DEFAULT (1) NOT NULL
, [ActiveFlag] bit DEFAULT (1) NOT NULL
, [PurchasingWebServiceURL] nvarchar(1024) NULL COLLATE NOCASE
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [PK_Vendor_BusinessEntityID] PRIMARY KEY ([BusinessEntityID])
, CONSTRAINT [FK_Vendor_BusinessEntity_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [BusinessEntity] ([BusinessEntityID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [ProductVendor] (
  [ProductID] int NOT NULL
, [BusinessEntityID] int NOT NULL
, [AverageLeadTime] int NOT NULL
, [StandardPrice] money NOT NULL
, [LastReceiptCost] money NULL
, [LastReceiptDate] datetime NULL
, [MinOrderQty] int NOT NULL
, [MaxOrderQty] int NOT NULL
, [OnOrderQty] int NULL
, [UnitMeasureCode] nchar(3) NOT NULL COLLATE NOCASE
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [PK_ProductVendor_ProductID_BusinessEntityID] PRIMARY KEY ([ProductID],[BusinessEntityID])
, CONSTRAINT [FK_ProductVendor_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Product] ([ProductID]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_ProductVendor_UnitMeasure_UnitMeasureCode] FOREIGN KEY ([UnitMeasureCode]) REFERENCES [UnitMeasure] ([UnitMeasureCode]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_ProductVendor_Vendor_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Vendor] ([BusinessEntityID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [Person] (
  [BusinessEntityID] int NOT NULL
, [PersonType] nchar(2) NOT NULL COLLATE NOCASE
, [NameStyle] bit DEFAULT (0) NOT NULL
, [Title] nvarchar(8) NULL COLLATE NOCASE
, [FirstName] nvarchar(50) NOT NULL COLLATE NOCASE
, [MiddleName] nvarchar(50) NULL COLLATE NOCASE
, [LastName] nvarchar(50) NOT NULL COLLATE NOCASE
, [Suffix] nvarchar(10) NULL COLLATE NOCASE
, [EmailPromotion] int DEFAULT (0) NOT NULL
, [AdditionalContactInfo] ntext NULL
, [Demographics] ntext NULL
, [rowguid] uniqueidentifier NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [PK_Person_BusinessEntityID] PRIMARY KEY ([BusinessEntityID])
, CONSTRAINT [FK_Person_BusinessEntity_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [BusinessEntity] ([BusinessEntityID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [PersonPhone] (
  [BusinessEntityID] int NOT NULL
, [PhoneNumber] nvarchar(25) NOT NULL COLLATE NOCASE
, [PhoneNumberTypeID] int NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [PK_PersonPhone_BusinessEntityID_PhoneNumber_PhoneNumberTypeID] PRIMARY KEY ([BusinessEntityID],[PhoneNumber],[PhoneNumberTypeID])
, CONSTRAINT [FK_PersonPhone_Person_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person] ([BusinessEntityID]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_PersonPhone_PhoneNumberType_PhoneNumberTypeID] FOREIGN KEY ([PhoneNumberTypeID]) REFERENCES [PhoneNumberType] ([PhoneNumberTypeID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [PersonCreditCard] (
  [BusinessEntityID] int NOT NULL
, [CreditCardID] int NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [PK_PersonCreditCard_BusinessEntityID_CreditCardID] PRIMARY KEY ([BusinessEntityID],[CreditCardID])
, CONSTRAINT [FK_PersonCreditCard_CreditCard_CreditCardID] FOREIGN KEY ([CreditCardID]) REFERENCES [CreditCard] ([CreditCardID]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_PersonCreditCard_Person_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person] ([BusinessEntityID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [Password] (
  [BusinessEntityID] int NOT NULL
, [PasswordHash] nvarchar(128) NOT NULL COLLATE NOCASE
, [PasswordSalt] nvarchar(10) NOT NULL COLLATE NOCASE
, [rowguid] uniqueidentifier NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [PK_Password_BusinessEntityID] PRIMARY KEY ([BusinessEntityID])
, CONSTRAINT [FK_Password_Person_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person] ([BusinessEntityID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [EmailAddress] (
  [BusinessEntityID] int NOT NULL
, [EmailAddressID] INTEGER NOT NULL
, [EmailAddress] nvarchar(50) NULL COLLATE NOCASE
, [rowguid] uniqueidentifier NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [PK_EmailAddress_BusinessEntityID_EmailAddressID] PRIMARY KEY ([BusinessEntityID],[EmailAddressID])
, CONSTRAINT [FK_EmailAddress_Person_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person] ([BusinessEntityID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [BusinessEntityContact] (
  [BusinessEntityID] int NOT NULL
, [PersonID] int NOT NULL
, [ContactTypeID] int NOT NULL
, [rowguid] uniqueidentifier NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [PK_BusinessEntityContact_BusinessEntityID_PersonID_ContactTypeID] PRIMARY KEY ([BusinessEntityID],[PersonID],[ContactTypeID])
, CONSTRAINT [FK_BusinessEntityContact_BusinessEntity_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [BusinessEntity] ([BusinessEntityID]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_BusinessEntityContact_ContactType_ContactTypeID] FOREIGN KEY ([ContactTypeID]) REFERENCES [ContactType] ([ContactTypeID]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_BusinessEntityContact_Person_PersonID] FOREIGN KEY ([PersonID]) REFERENCES [Person] ([BusinessEntityID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [AddressType] (
  [AddressTypeID] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [Name] nvarchar(50) NOT NULL COLLATE NOCASE
, [rowguid] uniqueidentifier NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
);
CREATE TABLE [Address] (
  [AddressID] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [AddressLine1] nvarchar(60) NOT NULL COLLATE NOCASE
, [AddressLine2] nvarchar(60) NULL COLLATE NOCASE
, [City] nvarchar(30) NOT NULL COLLATE NOCASE
, [StateProvinceID] int NOT NULL
, [PostalCode] nvarchar(15) NOT NULL COLLATE NOCASE
, [SpatialLocation] nvarchar(4000) NULL COLLATE NOCASE
, [rowguid] uniqueidentifier NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [FK_Address_StateProvince_StateProvinceID] FOREIGN KEY ([StateProvinceID]) REFERENCES [StateProvince] ([StateProvinceID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [BusinessEntityAddress] (
  [BusinessEntityID] int NOT NULL
, [AddressID] int NOT NULL
, [AddressTypeID] int NOT NULL
, [rowguid] uniqueidentifier NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressTypeID] PRIMARY KEY ([BusinessEntityID],[AddressID],[AddressTypeID])
, CONSTRAINT [FK_BusinessEntityAddress_Address_AddressID] FOREIGN KEY ([AddressID]) REFERENCES [Address] ([AddressID]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_BusinessEntityAddress_AddressType_AddressTypeID] FOREIGN KEY ([AddressTypeID]) REFERENCES [AddressType] ([AddressTypeID]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_BusinessEntityAddress_BusinessEntity_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [BusinessEntity] ([BusinessEntityID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [Shift] (
  [ShiftID] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [Name] nvarchar(50) NOT NULL COLLATE NOCASE
, [StartTime] nvarchar(16) NOT NULL COLLATE NOCASE
, [EndTime] nvarchar(16) NOT NULL COLLATE NOCASE
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
);
CREATE TABLE [Employee] (
  [BusinessEntityID] int NOT NULL
, [NationalIDNumber] nvarchar(15) NOT NULL COLLATE NOCASE
, [LoginID] nvarchar(256) NOT NULL COLLATE NOCASE
, [OrganizationNode] varbinary(892) NULL COLLATE NOCASE
, [JobTitle] nvarchar(50) NOT NULL COLLATE NOCASE
, [BirthDate] datetime NOT NULL
, [MaritalStatus] nchar(1) NOT NULL COLLATE NOCASE
, [Gender] nchar(1) NOT NULL COLLATE NOCASE
, [HireDate] datetime NOT NULL
, [SalariedFlag] bit DEFAULT (1) NOT NULL
, [VacationHours] smallint DEFAULT (0) NOT NULL
, [SickLeaveHours] smallint DEFAULT (0) NOT NULL
, [CurrentFlag] bit DEFAULT (1) NOT NULL
, [rowguid] uniqueidentifier NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [PK_Employee_BusinessEntityID] PRIMARY KEY ([BusinessEntityID])
, CONSTRAINT [FK_Employee_Person_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Person] ([BusinessEntityID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [SalesPerson] (
  [BusinessEntityID] int NOT NULL
, [TerritoryID] int NULL
, [SalesQuota] money NULL
, [Bonus] money DEFAULT (0.00) NOT NULL
, [CommissionPct] money DEFAULT (0.00) NOT NULL
, [SalesYTD] money DEFAULT (0.00) NOT NULL
, [SalesLastYear] money DEFAULT (0.00) NOT NULL
, [rowguid] uniqueidentifier NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [PK_SalesPerson_BusinessEntityID] PRIMARY KEY ([BusinessEntityID])
, CONSTRAINT [FK_SalesPerson_Employee_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Employee] ([BusinessEntityID]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_SalesPerson_SalesTerritory_TerritoryID] FOREIGN KEY ([TerritoryID]) REFERENCES [SalesTerritory] ([TerritoryID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [Store] (
  [BusinessEntityID] int NOT NULL
, [Name] nvarchar(50) NOT NULL COLLATE NOCASE
, [SalesPersonID] int NULL
, [Demographics] ntext NULL
, [rowguid] uniqueidentifier NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [PK_Store_BusinessEntityID] PRIMARY KEY ([BusinessEntityID])
, CONSTRAINT [FK_Store_BusinessEntity_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [BusinessEntity] ([BusinessEntityID]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_Store_SalesPerson_SalesPersonID] FOREIGN KEY ([SalesPersonID]) REFERENCES [SalesPerson] ([BusinessEntityID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [Customer] (
  [CustomerID] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [PersonID] int NULL
, [StoreID] int NULL
, [TerritoryID] int NULL
, [rowguid] uniqueidentifier NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [FK_Customer_Person_PersonID] FOREIGN KEY ([PersonID]) REFERENCES [Person] ([BusinessEntityID]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_Customer_SalesTerritory_TerritoryID] FOREIGN KEY ([TerritoryID]) REFERENCES [SalesTerritory] ([TerritoryID]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_Customer_Store_StoreID] FOREIGN KEY ([StoreID]) REFERENCES [Store] ([BusinessEntityID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [SalesTerritoryHistory] (
  [BusinessEntityID] int NOT NULL
, [TerritoryID] int NOT NULL
, [StartDate] datetime NOT NULL
, [EndDate] datetime NULL
, [rowguid] uniqueidentifier NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [PK_SalesTerritoryHistory_BusinessEntityID_StartDate_TerritoryID] PRIMARY KEY ([BusinessEntityID],[StartDate],[TerritoryID])
, CONSTRAINT [FK_SalesTerritoryHistory_SalesPerson_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [SalesPerson] ([BusinessEntityID]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_SalesTerritoryHistory_SalesTerritory_TerritoryID] FOREIGN KEY ([TerritoryID]) REFERENCES [SalesTerritory] ([TerritoryID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [SalesPersonQuotaHistory] (
  [BusinessEntityID] int NOT NULL
, [QuotaDate] datetime NOT NULL
, [SalesQuota] money NOT NULL
, [rowguid] uniqueidentifier NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [PK_SalesPersonQuotaHistory_BusinessEntityID_QuotaDate] PRIMARY KEY ([BusinessEntityID],[QuotaDate])
, CONSTRAINT [FK_SalesPersonQuotaHistory_SalesPerson_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [SalesPerson] ([BusinessEntityID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [SalesOrderHeader] (
  [SalesOrderID] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [RevisionNumber] tinyint DEFAULT (0) NOT NULL
, [OrderDate] datetime DEFAULT current_timestamp NOT NULL
, [DueDate] datetime NOT NULL
, [ShipDate] datetime NULL
, [Status] tinyint DEFAULT (1) NOT NULL
, [OnlineOrderFlag] bit DEFAULT (1) NOT NULL
, [PurchaseOrderNumber] nvarchar(25) NULL COLLATE NOCASE
, [AccountNumber] nvarchar(15) NULL COLLATE NOCASE
, [CustomerID] int NOT NULL
, [SalesPersonID] int NULL
, [TerritoryID] int NULL
, [BillToAddressID] int NOT NULL
, [ShipToAddressID] int NOT NULL
, [ShipMethodID] int NOT NULL
, [CreditCardID] int NULL
, [CreditCardApprovalCode] nvarchar(15) NULL COLLATE NOCASE
, [CurrencyRateID] int NULL
, [SubTotal] money DEFAULT (0.00) NOT NULL
, [TaxAmt] money DEFAULT (0.00) NOT NULL
, [Freight] money DEFAULT (0.00) NOT NULL
, [Comment] nvarchar(128) NULL COLLATE NOCASE
, [rowguid] uniqueidentifier NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [FK_SalesOrderHeader_Address_BillToAddressID] FOREIGN KEY ([BillToAddressID]) REFERENCES [Address] ([AddressID]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_SalesOrderHeader_Address_ShipToAddressID] FOREIGN KEY ([ShipToAddressID]) REFERENCES [Address] ([AddressID]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_SalesOrderHeader_CreditCard_CreditCardID] FOREIGN KEY ([CreditCardID]) REFERENCES [CreditCard] ([CreditCardID]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_SalesOrderHeader_CurrencyRate_CurrencyRateID] FOREIGN KEY ([CurrencyRateID]) REFERENCES [CurrencyRate] ([CurrencyRateID]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_SalesOrderHeader_Customer_CustomerID] FOREIGN KEY ([CustomerID]) REFERENCES [Customer] ([CustomerID]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_SalesOrderHeader_SalesPerson_SalesPersonID] FOREIGN KEY ([SalesPersonID]) REFERENCES [SalesPerson] ([BusinessEntityID]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_SalesOrderHeader_SalesTerritory_TerritoryID] FOREIGN KEY ([TerritoryID]) REFERENCES [SalesTerritory] ([TerritoryID]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_SalesOrderHeader_ShipMethod_ShipMethodID] FOREIGN KEY ([ShipMethodID]) REFERENCES [ShipMethod] ([ShipMethodID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [SalesOrderHeaderSalesReason] (
  [SalesOrderID] int NOT NULL
, [SalesReasonID] int NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [PK_SalesOrderHeaderSalesReason_SalesOrderID_SalesReasonID] PRIMARY KEY ([SalesOrderID],[SalesReasonID])
, CONSTRAINT [FK_SalesOrderHeaderSalesReason_SalesOrderHeader_SalesOrderID] FOREIGN KEY ([SalesOrderID]) REFERENCES [SalesOrderHeader] ([SalesOrderID]) ON DELETE CASCADE ON UPDATE NO ACTION
, CONSTRAINT [FK_SalesOrderHeaderSalesReason_SalesReason_SalesReasonID] FOREIGN KEY ([SalesReasonID]) REFERENCES [SalesReason] ([SalesReasonID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [SalesOrderDetail] (
  [SalesOrderID] int NOT NULL
, [SalesOrderDetailID] INTEGER NOT NULL
, [CarrierTrackingNumber] nvarchar(25) NULL COLLATE NOCASE
, [OrderQty] smallint NOT NULL
, [ProductID] int NOT NULL
, [SpecialOfferID] int NOT NULL
, [UnitPrice] money NOT NULL
, [UnitPriceDiscount] money DEFAULT (0.0) NOT NULL
, [rowguid] uniqueidentifier NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID] PRIMARY KEY ([SalesOrderID],[SalesOrderDetailID])
, CONSTRAINT [FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID] FOREIGN KEY ([SalesOrderID]) REFERENCES [SalesOrderHeader] ([SalesOrderID]) ON DELETE CASCADE ON UPDATE NO ACTION
, CONSTRAINT [FK_SalesOrderDetail_SpecialOfferProduct_SpecialOfferIDProductID] FOREIGN KEY ([SpecialOfferID], [ProductID]) REFERENCES [SpecialOfferProduct] ([SpecialOfferID], [ProductID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [PurchaseOrderHeader] (
  [PurchaseOrderID] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [RevisionNumber] tinyint DEFAULT (0) NOT NULL
, [Status] tinyint DEFAULT (1) NOT NULL
, [EmployeeID] int NOT NULL
, [VendorID] int NOT NULL
, [ShipMethodID] int NOT NULL
, [OrderDate] datetime DEFAULT current_timestamp NOT NULL
, [ShipDate] datetime NULL
, [SubTotal] money DEFAULT (0.00) NOT NULL
, [TaxAmt] money DEFAULT (0.00) NOT NULL
, [Freight] money DEFAULT (0.00) NOT NULL
, [TotalDue] money NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [FK_PurchaseOrderHeader_Employee_EmployeeID] FOREIGN KEY ([EmployeeID]) REFERENCES [Employee] ([BusinessEntityID]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_PurchaseOrderHeader_ShipMethod_ShipMethodID] FOREIGN KEY ([ShipMethodID]) REFERENCES [ShipMethod] ([ShipMethodID]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_PurchaseOrderHeader_Vendor_VendorID] FOREIGN KEY ([VendorID]) REFERENCES [Vendor] ([BusinessEntityID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [PurchaseOrderDetail] (
  [PurchaseOrderID] int NOT NULL
, [PurchaseOrderDetailID] INTEGER NOT NULL
, [DueDate] datetime NOT NULL
, [OrderQty] smallint NOT NULL
, [ProductID] int NOT NULL
, [UnitPrice] money NOT NULL
, [ReceivedQty] numeric(8,2) NOT NULL
, [RejectedQty] numeric(8,2) NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [PK_PurchaseOrderDetail_PurchaseOrderID_PurchaseOrderDetailID] PRIMARY KEY ([PurchaseOrderID],[PurchaseOrderDetailID])
, CONSTRAINT [FK_PurchaseOrderDetail_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Product] ([ProductID]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_PurchaseOrderDetail_PurchaseOrderHeader_PurchaseOrderID] FOREIGN KEY ([PurchaseOrderID]) REFERENCES [PurchaseOrderHeader] ([PurchaseOrderID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [JobCandidate] (
  [JobCandidateID] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [BusinessEntityID] int NULL
, [Resume] ntext NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [FK_JobCandidate_Employee_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Employee] ([BusinessEntityID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [EmployeePayHistory] (
  [BusinessEntityID] int NOT NULL
, [RateChangeDate] datetime NOT NULL
, [Rate] money NOT NULL
, [PayFrequency] tinyint NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [PK_EmployeePayHistory_BusinessEntityID_RateChangeDate] PRIMARY KEY ([BusinessEntityID],[RateChangeDate])
, CONSTRAINT [FK_EmployeePayHistory_Employee_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Employee] ([BusinessEntityID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [Document] (
  [DocumentNode] varbinary(892) NOT NULL
, [Title] nvarchar(50) NOT NULL COLLATE NOCASE
, [Owner] int NOT NULL
, [FolderFlag] bit DEFAULT (0) NOT NULL
, [FileName] nvarchar(400) NOT NULL COLLATE NOCASE
, [FileExtension] nvarchar(8) NOT NULL COLLATE NOCASE
, [Revision] nchar(5) NOT NULL COLLATE NOCASE
, [ChangeNumber] int DEFAULT (0) NOT NULL
, [Status] tinyint NOT NULL
, [DocumentSummary] ntext NULL
, [Document] image NULL
, [rowguid] uniqueidentifier NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [PK_Document_DocumentNode] PRIMARY KEY ([DocumentNode])
, CONSTRAINT [FK_Document_Employee_Owner] FOREIGN KEY ([Owner]) REFERENCES [Employee] ([BusinessEntityID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [ProductDocument] (
  [ProductID] int NOT NULL
, [DocumentNode] varbinary(892) NOT NULL COLLATE NOCASE
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [PK_ProductDocument_ProductID_DocumentNode] PRIMARY KEY ([ProductID],[DocumentNode])
, CONSTRAINT [FK_ProductDocument_Document_DocumentNode] FOREIGN KEY ([DocumentNode]) REFERENCES [Document] ([DocumentNode]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_ProductDocument_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Product] ([ProductID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [Department] (
  [DepartmentID] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [Name] nvarchar(50) NOT NULL COLLATE NOCASE
, [GroupName] nvarchar(50) NOT NULL COLLATE NOCASE
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
);
CREATE TABLE [EmployeeDepartmentHistory] (
  [BusinessEntityID] int NOT NULL
, [DepartmentID] int NOT NULL
, [ShiftID] int NOT NULL
, [StartDate] datetime NOT NULL
, [EndDate] datetime NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
, CONSTRAINT [PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_DepartmentID] PRIMARY KEY ([BusinessEntityID],[StartDate],[DepartmentID],[ShiftID])
, CONSTRAINT [FK_EmployeeDepartmentHistory_Department_DepartmentID] FOREIGN KEY ([DepartmentID]) REFERENCES [Department] ([DepartmentID]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_EmployeeDepartmentHistory_Employee_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [Employee] ([BusinessEntityID]) ON DELETE NO ACTION ON UPDATE NO ACTION
, CONSTRAINT [FK_EmployeeDepartmentHistory_Shift_ShiftID] FOREIGN KEY ([ShiftID]) REFERENCES [Shift] ([ShiftID]) ON DELETE NO ACTION ON UPDATE NO ACTION
);
CREATE TABLE [ErrorLog] (
  [ErrorLogID] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [ErrorTime] datetime DEFAULT current_timestamp NOT NULL
, [UserName] nvarchar(128) NOT NULL COLLATE NOCASE
, [ErrorNumber] int NOT NULL
, [ErrorSeverity] int NULL
, [ErrorState] int NULL
, [ErrorProcedure] nvarchar(126) NULL COLLATE NOCASE
, [ErrorLine] int NULL
, [ErrorMessage] nvarchar(4000) NOT NULL COLLATE NOCASE
);
CREATE TABLE [DatabaseLog] (
  [DatabaseLogID] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [PostTime] datetime NOT NULL
, [DatabaseUser] nvarchar(128) NOT NULL COLLATE NOCASE
, [Event] nvarchar(128) NOT NULL COLLATE NOCASE
, [Schema] nvarchar(128) NULL COLLATE NOCASE
, [Object] nvarchar(128) NULL COLLATE NOCASE
, [TSQL] ntext NOT NULL
, [XmlEvent] ntext NOT NULL
);
CREATE TABLE [AWBuildVersion] (
  [SystemInformationID] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, [Database Version] nvarchar(25) NOT NULL COLLATE NOCASE
, [VersionDate] datetime NOT NULL
, [ModifiedDate] datetime DEFAULT current_timestamp NOT NULL
);
COMMIT;