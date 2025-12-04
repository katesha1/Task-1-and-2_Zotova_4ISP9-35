-- 1. Предметные области (физика, химия, биология и т.д.)
CREATE TABLE SubjectAreas (
    SubjectAreaID INT IDENTITY(1,1) PRIMARY KEY,
    SubjectAreaName NVARCHAR(100) NOT NULL
);

-- 2. Типы оборудования (демонстрационное, лабораторное, измерительное и пр.)
CREATE TABLE EquipmentTypes (
    EquipmentTypeID INT IDENTITY(1,1) PRIMARY KEY,
    TypeName NVARCHAR(100) NOT NULL
);

-- 3. Требования к инфраструктуре (электропитание, вода, вентиляция и т.д.)
CREATE TABLE InfrastructureRequirements (
    RequirementID INT IDENTITY(1,1) PRIMARY KEY,
    RequirementName NVARCHAR(200) NOT NULL,
    Description NVARCHAR(500)
);

-- 4. Нормативные документы (ссылки на СанПиН, ГОСТ, Приказы и т.д.)
CREATE TABLE RegulatoryDocuments (
    DocumentID INT IDENTITY(1,1) PRIMARY KEY,
    DocumentName NVARCHAR(300) NOT NULL,
    DocumentNumber NVARCHAR(50),
    DateIssued DATE,
    URL NVARCHAR(500)
);

-- 5. Основная таблица: Учебно-лабораторное оборудование
CREATE TABLE LabEquipment (
    EquipmentID INT IDENTITY(1,1) PRIMARY KEY,
    EquipmentName NVARCHAR(255) NOT NULL,                      -- Наименование оборудования
    EquipmentDescription NVARCHAR(MAX),
    TechSpecs NVARCHAR(MAX) NOT NULL,                          -- Технические характеристики оборудования
    WebURL NVARCHAR(500),                                      -- Ссылка на страницу в сети Интернет
    IsMandatory BIT NOT NULL DEFAULT 1,                        -- Обязательное (1) или вариативное (0)
    SubjectAreaID INT NOT NULL,
    EquipmentTypeID INT NOT NULL,
    SafetyRequirements NVARCHAR(500),                          -- Требования по безопасности
    StorageConditions NVARCHAR(300),                           -- Условия хранения
    MaintenanceIntervalMonths INT,                             -- Интервал ТО в месяцах
    Manufacturer NVARCHAR(150),
    ComplianceNotes NVARCHAR(MAX),                             -- Соответствие Приказу №838
    InfrastructureNotes NVARCHAR(500),                         -- Особые требования к инфраструктуре (вода, электричество и т.д.)
    EquipmentCode NVARCHAR(50),                                -- Код из Приказа (например, 2.14.11)
    CONSTRAINT FK_LabEquipment_SubjectArea FOREIGN KEY (SubjectAreaID) REFERENCES SubjectAreas(SubjectAreaID),
    CONSTRAINT FK_LabEquipment_EquipmentType FOREIGN KEY (EquipmentTypeID) REFERENCES EquipmentTypes(EquipmentTypeID)
);

-- 6. Связь оборудования с требованиями к инфраструктуре (многие-ко-многим)
CREATE TABLE EquipmentInfrastructure (
    EquipmentID INT,
    RequirementID INT,
    PRIMARY KEY (EquipmentID, RequirementID),
    CONSTRAINT FK_EquipInfra_Equipment FOREIGN KEY (EquipmentID) REFERENCES LabEquipment(EquipmentID) ON DELETE CASCADE,
    CONSTRAINT FK_EquipInfra_Requirement FOREIGN KEY (RequirementID) REFERENCES InfrastructureRequirements(RequirementID)
);

-- 7. Связь оборудования с нормативными документами
CREATE TABLE EquipmentRegulations (
    EquipmentID INT,
    DocumentID INT,
    PRIMARY KEY (EquipmentID, DocumentID),
    CONSTRAINT FK_EquipReg_Equipment FOREIGN KEY (EquipmentID) REFERENCES LabEquipment(EquipmentID) ON DELETE CASCADE,
    CONSTRAINT FK_EquipReg_Document FOREIGN KEY (DocumentID) REFERENCES RegulatoryDocuments(DocumentID)
);
