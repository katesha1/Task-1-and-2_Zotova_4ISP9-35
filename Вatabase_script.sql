
CREATE TABLE SubjectAreas (
    SubjectAreaID INT IDENTITY(1,1) PRIMARY KEY,
    SubjectAreaName NVARCHAR(100) NOT NULL
);


CREATE TABLE EquipmentTypes (
    EquipmentTypeID INT IDENTITY(1,1) PRIMARY KEY,
    TypeName NVARCHAR(100) NOT NULL
);


CREATE TABLE InfrastructureRequirements (
    RequirementID INT IDENTITY(1,1) PRIMARY KEY,
    RequirementName NVARCHAR(200) NOT NULL,
    Description NVARCHAR(500)
);

CREATE TABLE RegulatoryDocuments (
    DocumentID INT IDENTITY(1,1) PRIMARY KEY,
    DocumentName NVARCHAR(300) NOT NULL,
    DocumentNumber NVARCHAR(50),
    DateIssued DATE,
    URL NVARCHAR(500)
);

CREATE TABLE LabEquipment (
    EquipmentID INT IDENTITY(1,1) PRIMARY KEY,
    EquipmentName NVARCHAR(255) NOT NULL,                     
    EquipmentDescription NVARCHAR(MAX),
    TechSpecs NVARCHAR(MAX) NOT NULL,                         
    WebURL NVARCHAR(500),                                      
    IsMandatory BIT NOT NULL DEFAULT 1,                        
    SubjectAreaID INT NOT NULL,
    EquipmentTypeID INT NOT NULL,
    SafetyRequirements NVARCHAR(500),                         
    StorageConditions NVARCHAR(300),                          
    MaintenanceIntervalMonths INT,                            
    Manufacturer NVARCHAR(150),
    ComplianceNotes NVARCHAR(MAX),                             
    InfrastructureNotes NVARCHAR(500),                         
    EquipmentCode NVARCHAR(50),                               
    CONSTRAINT FK_LabEquipment_SubjectArea FOREIGN KEY (SubjectAreaID) REFERENCES SubjectAreas(SubjectAreaID),
    CONSTRAINT FK_LabEquipment_EquipmentType FOREIGN KEY (EquipmentTypeID) REFERENCES EquipmentTypes(EquipmentTypeID)
);


CREATE TABLE EquipmentInfrastructure (
    EquipmentID INT,
    RequirementID INT,
    PRIMARY KEY (EquipmentID, RequirementID),
    CONSTRAINT FK_EquipInfra_Equipment FOREIGN KEY (EquipmentID) REFERENCES LabEquipment(EquipmentID) ON DELETE CASCADE,
    CONSTRAINT FK_EquipInfra_Requirement FOREIGN KEY (RequirementID) REFERENCES InfrastructureRequirements(RequirementID)
);


CREATE TABLE EquipmentRegulations (
    EquipmentID INT,
    DocumentID INT,
    PRIMARY KEY (EquipmentID, DocumentID),
    CONSTRAINT FK_EquipReg_Equipment FOREIGN KEY (EquipmentID) REFERENCES LabEquipment(EquipmentID) ON DELETE CASCADE,
    CONSTRAINT FK_EquipReg_Document FOREIGN KEY (DocumentID) REFERENCES RegulatoryDocuments(DocumentID)

);
