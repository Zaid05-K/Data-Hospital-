-- نظام إدارة المستشفيات - نصوص إنشاء الجداول (DDL)

-- حذف الجداول الموجودة إذا كانت موجودة (لتجنب أخطاء عند إعادة التشغيل)
DROP TABLE BillDetails CASCADE CONSTRAINTS;
DROP TABLE Bills CASCADE CONSTRAINTS;
DROP TABLE TestResults CASCADE CONSTRAINTS;
DROP TABLE LabTests CASCADE CONSTRAINTS;
DROP TABLE PrescriptionDetails CASCADE CONSTRAINTS;
DROP TABLE Prescriptions CASCADE CONSTRAINTS;
DROP TABLE Medications CASCADE CONSTRAINTS;
DROP TABLE Admissions CASCADE CONSTRAINTS;
DROP TABLE Appointments CASCADE CONSTRAINTS;
DROP TABLE Rooms CASCADE CONSTRAINTS;
DROP TABLE Nurses CASCADE CONSTRAINTS;
DROP TABLE Doctors CASCADE CONSTRAINTS;
DROP TABLE Departments CASCADE CONSTRAINTS;
DROP TABLE Patients CASCADE CONSTRAINTS;

-- إنشاء جدول المرضى
CREATE TABLE Patients (
    PatientID NUMBER PRIMARY KEY,
    FirstName VARCHAR2(50) NOT NULL,
    LastName VARCHAR2(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender VARCHAR2(10) CHECK (Gender IN ('ذكر', 'أنثى')),
    Address VARCHAR2(200),
    PhoneNumber VARCHAR2(20) NOT NULL,
    Email VARCHAR2(100),
    BloodType VARCHAR2(5) CHECK (BloodType IN ('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-')),
    RegistrationDate DATE DEFAULT SYSDATE NOT NULL
);

-- إنشاء جدول الأقسام
CREATE TABLE Departments (
    DepartmentID NUMBER PRIMARY KEY,
    DepartmentName VARCHAR2(100) NOT NULL,
    Description VARCHAR2(500),
    Location VARCHAR2(100) NOT NULL,
    HeadDoctorID NUMBER
    -- سيتم إضافة القيد الأجنبي لاحقاً بعد إنشاء جدول الأطباء
);

-- إنشاء جدول الأطباء
CREATE TABLE Doctors (
    DoctorID NUMBER PRIMARY KEY,
    FirstName VARCHAR2(50) NOT NULL,
    LastName VARCHAR2(50) NOT NULL,
    Specialization VARCHAR2(100) NOT NULL,
    Qualifications VARCHAR2(200),
    PhoneNumber VARCHAR2(20) NOT NULL,
    Email VARCHAR2(100),
    HireDate DATE DEFAULT SYSDATE NOT NULL,
    Salary NUMBER(10,2) CHECK (Salary > 0),
    DepartmentID NUMBER NOT NULL,
    CONSTRAINT fk_doctor_department FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- إضافة القيد الأجنبي لرئيس القسم في جدول الأقسام
ALTER TABLE Departments
ADD CONSTRAINT fk_department_head FOREIGN KEY (HeadDoctorID) REFERENCES Doctors(DoctorID);

-- إنشاء جدول الممرضين
CREATE TABLE Nurses (
    NurseID NUMBER PRIMARY KEY,
    FirstName VARCHAR2(50) NOT NULL,
    LastName VARCHAR2(50) NOT NULL,
    Qualifications VARCHAR2(200),
    PhoneNumber VARCHAR2(20) NOT NULL,
    Email VARCHAR2(100),
    HireDate DATE DEFAULT SYSDATE NOT NULL,
    Salary NUMBER(10,2) CHECK (Salary > 0),
    DepartmentID NUMBER NOT NULL,
    CONSTRAINT fk_nurse_department FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- إنشاء جدول الغرف
CREATE TABLE Rooms (
    RoomID NUMBER PRIMARY KEY,
    RoomType VARCHAR2(50) NOT NULL CHECK (RoomType IN ('عادية', 'خاصة', 'عناية مركزة', 'غرفة عمليات')),
    Status VARCHAR2(20) NOT NULL CHECK (Status IN ('متاحة', 'مشغولة', 'تحت الصيانة')),
    DailyCost NUMBER(10,2) CHECK (DailyCost >= 0),
    DepartmentID NUMBER NOT NULL,
    CONSTRAINT fk_room_department FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- إنشاء جدول المواعيد
CREATE TABLE Appointments (
    AppointmentID NUMBER PRIMARY KEY,
    AppointmentDate DATE NOT NULL,
    AppointmentTime VARCHAR2(10) NOT NULL,
    Status VARCHAR2(20) NOT NULL CHECK (Status IN ('مجدول', 'ملغى', 'مكتمل')),
    AppointmentType VARCHAR2(50) NOT NULL CHECK (AppointmentType IN ('استشارة', 'متابعة', 'طوارئ')),
    PatientID NUMBER NOT NULL,
    DoctorID NUMBER NOT NULL,
    CONSTRAINT fk_appointment_patient FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    CONSTRAINT fk_appointment_doctor FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- إنشاء جدول الإقامة في المستشفى
CREATE TABLE Admissions (
    AdmissionID NUMBER PRIMARY KEY,
    AdmissionDate DATE NOT NULL,
    DischargeDate DATE,
    AdmissionReason VARCHAR2(500) NOT NULL,
    PatientID NUMBER NOT NULL,
    RoomID NUMBER NOT NULL,
    AttendingDoctorID NUMBER NOT NULL,
    CONSTRAINT fk_admission_patient FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    CONSTRAINT fk_admission_room FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID),
    CONSTRAINT fk_admission_doctor FOREIGN KEY (AttendingDoctorID) REFERENCES Doctors(DoctorID),
    CONSTRAINT check_discharge_date CHECK (DischargeDate IS NULL OR DischargeDate >= AdmissionDate)
);

-- إنشاء جدول الأدوية
CREATE TABLE Medications (
    MedicationID NUMBER PRIMARY KEY,
    MedicationName VARCHAR2(100) NOT NULL,
    Description VARCHAR2(500),
    RecommendedDosage VARCHAR2(100),
    Instructions VARCHAR2(500),
    Price NUMBER(10,2) CHECK (Price >= 0),
    QuantityInStock NUMBER CHECK (QuantityInStock >= 0)
);

-- إنشاء جدول الوصفات الطبية
CREATE TABLE Prescriptions (
    PrescriptionID NUMBER PRIMARY KEY,
    PrescriptionDate DATE DEFAULT SYSDATE NOT NULL,
    PatientID NUMBER NOT NULL,
    DoctorID NUMBER NOT NULL,
    CONSTRAINT fk_prescription_patient FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    CONSTRAINT fk_prescription_doctor FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- إنشاء جدول تفاصيل الوصفة
CREATE TABLE PrescriptionDetails (
    PrescriptionID NUMBER,
    MedicationID NUMBER,
    Dosage VARCHAR2(50) NOT NULL,
    Frequency VARCHAR2(50) NOT NULL,
    Duration VARCHAR2(50) NOT NULL,
    Quantity NUMBER NOT NULL CHECK (Quantity > 0),
    PRIMARY KEY (PrescriptionID, MedicationID),
    CONSTRAINT fk_prescdetail_prescription FOREIGN KEY (PrescriptionID) REFERENCES Prescriptions(PrescriptionID),
    CONSTRAINT fk_prescdetail_medication FOREIGN KEY (MedicationID) REFERENCES Medications(MedicationID)
);

-- إنشاء جدول الفحوصات المخبرية
CREATE TABLE LabTests (
    TestID NUMBER PRIMARY KEY,
    TestName VARCHAR2(100) NOT NULL,
    Description VARCHAR2(500),
    Cost NUMBER(10,2) CHECK (Cost >= 0)
);

-- إنشاء جدول نتائج الفحوصات
CREATE TABLE TestResults (
    ResultID NUMBER PRIMARY KEY,
    TestDate DATE DEFAULT SYSDATE NOT NULL,
    Result VARCHAR2(500) NOT NULL,
    Comments VARCHAR2(500),
    PatientID NUMBER NOT NULL,
    TestID NUMBER NOT NULL,
    RequestingDoctorID NUMBER NOT NULL,
    CONSTRAINT fk_testresult_patient FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    CONSTRAINT fk_testresult_test FOREIGN KEY (TestID) REFERENCES LabTests(TestID),
    CONSTRAINT fk_testresult_doctor FOREIGN KEY (RequestingDoctorID) REFERENCES Doctors(DoctorID)
);

-- إنشاء جدول الفواتير
CREATE TABLE Bills (
    BillID NUMBER PRIMARY KEY,
    BillDate DATE DEFAULT SYSDATE NOT NULL,
    TotalAmount NUMBER(12,2) CHECK (TotalAmount >= 0),
    PaymentStatus VARCHAR2(20) NOT NULL CHECK (PaymentStatus IN ('مدفوعة', 'غير مدفوعة', 'مدفوعة جزئياً')),
    PaymentMethod VARCHAR2(20) CHECK (PaymentMethod IN ('نقداً', 'بطاقة ائتمان', 'تأمين')),
    PatientID NUMBER NOT NULL,
    AdmissionID NUMBER,
    CONSTRAINT fk_bill_patient FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    CONSTRAINT fk_bill_admission FOREIGN KEY (AdmissionID) REFERENCES Admissions(AdmissionID)
);

-- إنشاء جدول تفاصيل الفاتورة
CREATE TABLE BillDetails (
    BillID NUMBER,
    ItemID NUMBER,
    ItemDescription VARCHAR2(200) NOT NULL,
    Quantity NUMBER NOT NULL CHECK (Quantity > 0),
    UnitPrice NUMBER(10,2) NOT NULL CHECK (UnitPrice >= 0),
    Amount NUMBER(12,2) GENERATED ALWAYS AS (Quantity * UnitPrice) STORED,
    PRIMARY KEY (BillID, ItemID),
    CONSTRAINT fk_billdetail_bill FOREIGN KEY (BillID) REFERENCES Bills(BillID)
);

-- إنشاء تسلسلات لتوليد المفاتيح الأساسية
CREATE SEQUENCE seq_patient_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_department_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_doctor_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_nurse_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_room_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_appointment_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_admission_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_medication_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_prescription_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_test_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_result_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_bill_id START WITH 1 INCREMENT BY 1;

-- إنشاء مشغلات (Triggers) لتوليد المفاتيح الأساسية تلقائياً
CREATE OR REPLACE TRIGGER trg_patient_id
BEFORE INSERT ON Patients
FOR EACH ROW
BEGIN
    IF :NEW.PatientID IS NULL THEN
        SELECT seq_patient_id.NEXTVAL INTO :NEW.PatientID FROM DUAL;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_department_id
BEFORE INSERT ON Departments
FOR EACH ROW
BEGIN
    IF :NEW.DepartmentID IS NULL THEN
        SELECT seq_department_id.NEXTVAL INTO :NEW.DepartmentID FROM DUAL;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_doctor_id
BEFORE INSERT ON Doctors
FOR EACH ROW
BEGIN
    IF :NEW.DoctorID IS NULL THEN
        SELECT seq_doctor_id.NEXTVAL INTO :NEW.DoctorID FROM DUAL;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_nurse_id
BEFORE INSERT ON Nurses
FOR EACH ROW
BEGIN
    IF :NEW.NurseID IS NULL THEN
        SELECT seq_nurse_id.NEXTVAL INTO :NEW.NurseID FROM DUAL;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_room_id
BEFORE INSERT ON Rooms
FOR EACH ROW
BEGIN
    IF :NEW.RoomID IS NULL THEN
        SELECT seq_room_id.NEXTVAL INTO :NEW.RoomID FROM DUAL;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_appointment_id
BEFORE INSERT ON Appointments
FOR EACH ROW
BEGIN
    IF :NEW.AppointmentID IS NULL THEN
        SELECT seq_appointment_id.NEXTVAL INTO :NEW.AppointmentID FROM DUAL;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_admission_id
BEFORE INSERT ON Admissions
FOR EACH ROW
BEGIN
    IF :NEW.AdmissionID IS NULL THEN
        SELECT seq_admission_id.NEXTVAL INTO :NEW.AdmissionID FROM DUAL;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_medication_id
BEFORE INSERT ON Medications
FOR EACH ROW
BEGIN
    IF :NEW.MedicationID IS NULL THEN
        SELECT seq_medication_id.NEXTVAL INTO :NEW.MedicationID FROM DUAL;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_prescription_id
BEFORE INSERT ON Prescriptions
FOR EACH ROW
BEGIN
    IF :NEW.PrescriptionID IS NULL THEN
        SELECT seq_prescription_id.NEXTVAL INTO :NEW.PrescriptionID FROM DUAL;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_test_id
BEFORE INSERT ON LabTests
FOR EACH ROW
BEGIN
    IF :NEW.TestID IS NULL THEN
        SELECT seq_test_id.NEXTVAL INTO :NEW.TestID FROM DUAL;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_result_id
BEFORE INSERT ON TestResults
FOR EACH ROW
BEGIN
    IF :NEW.ResultID IS NULL THEN
        SELECT seq_result_id.NEXTVAL INTO :NEW.ResultID FROM DUAL;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_bill_id
BEFORE INSERT ON Bills
FOR EACH ROW
BEGIN
    IF :NEW.BillID IS NULL THEN
        SELECT seq_bill_id.NEXTVAL INTO :NEW.BillID FROM DUAL;
    END IF;
END;
/

-- إنشاء مشغل لتحديث حالة الغرفة عند الإقامة
CREATE OR REPLACE TRIGGER trg_room_status_admission
AFTER INSERT OR UPDATE ON Admissions
FOR EACH ROW
BEGIN
    IF :NEW.DischargeDate IS NULL THEN
        -- إذا كان المريض لا يزال مقيماً، قم بتحديث حالة الغرفة إلى "مشغولة"
        UPDATE Rooms SET Status = 'مشغولة' WHERE RoomID = :NEW.RoomID;
    ELSE
        -- إذا تم تسجيل خروج المريض، قم بتحديث حالة الغرفة إلى "متاحة"
        UPDATE Rooms SET Status = 'متاحة' WHERE RoomID = :NEW.RoomID;
    END IF;
END;
/

-- إنشاء مشغل لتحديث كمية الدواء المتاحة عند إضافة وصفة طبية
CREATE OR REPLACE TRIGGER trg_medication_quantity
AFTER INSERT ON PrescriptionDetails
FOR EACH ROW
BEGIN
    UPDATE Medications
    SET QuantityInStock = QuantityInStock - :NEW.Quantity
    WHERE MedicationID = :NEW.MedicationID;
END;
/

-- إنشاء مشغل للتحقق من توفر الدواء قبل إضافة وصفة طبية
CREATE OR REPLACE TRIGGER trg_check_medication_availability
BEFORE INSERT ON PrescriptionDetails
FOR EACH ROW
DECLARE
    v_available_quantity NUMBER;
BEGIN
    SELECT QuantityInStock INTO v_available_quantity
    FROM Medications
    WHERE MedicationID = :NEW.MedicationID;
    
    IF v_available_quantity < :NEW.Quantity THEN
        RAISE_APPLICATION_ERROR(-20001, 'الكمية المطلوبة من الدواء غير متوفرة في المخزون');
    END IF;
END;
/

-- إنشاء مشغل لحساب إجمالي مبلغ الفاتورة
CREATE OR REPLACE TRIGGER trg_calculate_bill_total
AFTER INSERT OR UPDATE OR DELETE ON BillDetails
FOR EACH ROW
DECLARE
    v_total NUMBER;
BEGIN
    IF INSERTING OR UPDATING THEN
        -- حساب إجمالي مبلغ الفاتورة
        SELECT SUM(Amount) INTO v_total
        FROM BillDetails
        WHERE BillID = :NEW.BillID;
        
        -- تحديث إجمالي مبلغ الفاتورة
        UPDATE Bills
        SET TotalAmount = v_total
        WHERE BillID = :NEW.BillID;
    ELSIF DELETING THEN
        -- حساب إجمالي مبلغ الفاتورة
        SELECT SUM(Amount) INTO v_total
        FROM BillDetails
        WHERE BillID = :OLD.BillID;
        
        -- تحديث إجمالي مبلغ الفاتورة
        UPDATE Bills
        SET TotalAmount = v_total
        WHERE BillID = :OLD.BillID;
    END IF;
END;
/

COMMIT;
