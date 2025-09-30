# النموذج العلائقي لنظام إدارة المستشفيات

## تحويل مخطط ER إلى نموذج علائقي

فيما يلي النموذج العلائقي المشتق من مخطط العلاقات بين الكيانات (ER) لنظام إدارة المستشفيات. تم تحديد المفاتيح الأساسية بخط **غامق** والمفاتيح الأجنبية بخط *مائل*.

### 1. المرضى (Patients)
```
Patients(
    **PatientID**, 
    FirstName, 
    LastName, 
    DateOfBirth, 
    Gender, 
    Address, 
    PhoneNumber, 
    Email, 
    BloodType, 
    RegistrationDate
)
```

### 2. الأطباء (Doctors)
```
Doctors(
    **DoctorID**, 
    FirstName, 
    LastName, 
    Specialization, 
    Qualifications, 
    PhoneNumber, 
    Email, 
    HireDate, 
    Salary, 
    *DepartmentID*
)
```
- *DepartmentID* يشير إلى Departments(DepartmentID)

### 3. الممرضون (Nurses)
```
Nurses(
    **NurseID**, 
    FirstName, 
    LastName, 
    Qualifications, 
    PhoneNumber, 
    Email, 
    HireDate, 
    Salary, 
    *DepartmentID*
)
```
- *DepartmentID* يشير إلى Departments(DepartmentID)

### 4. الأقسام (Departments)
```
Departments(
    **DepartmentID**, 
    DepartmentName, 
    Description, 
    Location, 
    *HeadDoctorID*
)
```
- *HeadDoctorID* يشير إلى Doctors(DoctorID)

### 5. الغرف (Rooms)
```
Rooms(
    **RoomID**, 
    RoomType, 
    Status, 
    DailyCost, 
    *DepartmentID*
)
```
- *DepartmentID* يشير إلى Departments(DepartmentID)

### 6. المواعيد (Appointments)
```
Appointments(
    **AppointmentID**, 
    AppointmentDate, 
    AppointmentTime, 
    Status, 
    AppointmentType, 
    *PatientID*, 
    *DoctorID*
)
```
- *PatientID* يشير إلى Patients(PatientID)
- *DoctorID* يشير إلى Doctors(DoctorID)

### 7. الإقامة في المستشفى (Admissions)
```
Admissions(
    **AdmissionID**, 
    AdmissionDate, 
    DischargeDate, 
    AdmissionReason, 
    *PatientID*, 
    *RoomID*, 
    *AttendingDoctorID*
)
```
- *PatientID* يشير إلى Patients(PatientID)
- *RoomID* يشير إلى Rooms(RoomID)
- *AttendingDoctorID* يشير إلى Doctors(DoctorID)

### 8. الأدوية (Medications)
```
Medications(
    **MedicationID**, 
    MedicationName, 
    Description, 
    RecommendedDosage, 
    Instructions, 
    Price, 
    QuantityInStock
)
```

### 9. الوصفات الطبية (Prescriptions)
```
Prescriptions(
    **PrescriptionID**, 
    PrescriptionDate, 
    *PatientID*, 
    *DoctorID*
)
```
- *PatientID* يشير إلى Patients(PatientID)
- *DoctorID* يشير إلى Doctors(DoctorID)

### 10. تفاصيل الوصفة (PrescriptionDetails)
```
PrescriptionDetails(
    ***PrescriptionID***, 
    ***MedicationID***, 
    Dosage, 
    Frequency, 
    Duration, 
    Quantity
)
```
- *PrescriptionID* يشير إلى Prescriptions(PrescriptionID)
- *MedicationID* يشير إلى Medications(MedicationID)
- المفتاح الأساسي هو مزيج من (PrescriptionID, MedicationID)

### 11. الفحوصات المخبرية (LabTests)
```
LabTests(
    **TestID**, 
    TestName, 
    Description, 
    Cost
)
```

### 12. نتائج الفحوصات (TestResults)
```
TestResults(
    **ResultID**, 
    TestDate, 
    Result, 
    Comments, 
    *PatientID*, 
    *TestID*, 
    *RequestingDoctorID*
)
```
- *PatientID* يشير إلى Patients(PatientID)
- *TestID* يشير إلى LabTests(TestID)
- *RequestingDoctorID* يشير إلى Doctors(DoctorID)

### 13. الفواتير (Bills)
```
Bills(
    **BillID**, 
    BillDate, 
    TotalAmount, 
    PaymentStatus, 
    PaymentMethod, 
    *PatientID*, 
    *AdmissionID*
)
```
- *PatientID* يشير إلى Patients(PatientID)
- *AdmissionID* يشير إلى Admissions(AdmissionID) (قد يكون NULL)

### 14. تفاصيل الفاتورة (BillDetails)
```
BillDetails(
    ***BillID***, 
    **ItemID**, 
    ItemDescription, 
    Quantity, 
    UnitPrice, 
    Amount
)
```
- *BillID* يشير إلى Bills(BillID)
- المفتاح الأساسي هو مزيج من (BillID, ItemID)

## ملاحظات التطبيع (Normalization)

1. **الشكل الطبيعي الأول (1NF)**: جميع الجداول في الشكل الطبيعي الأول حيث أن جميع القيم ذرية (غير قابلة للتجزئة) ولا توجد مجموعات متكررة.

2. **الشكل الطبيعي الثاني (2NF)**: جميع الجداول في الشكل الطبيعي الثاني حيث أن جميع الصفات غير المفتاحية تعتمد بشكل كامل على المفتاح الأساسي. تم تحقيق ذلك من خلال إنشاء جداول منفصلة مثل PrescriptionDetails وBillDetails لتمثيل العلاقات متعددة إلى متعددة.

3. **الشكل الطبيعي الثالث (3NF)**: جميع الجداول في الشكل الطبيعي الثالث حيث لا توجد اعتمادات انتقالية. على سبيل المثال، تم فصل معلومات الأقسام والغرف والأدوية إلى جداول منفصلة.

## حل العلاقات متعددة إلى متعددة (N:M)

1. **الوصفات والأدوية**: تم حل العلاقة متعددة إلى متعددة بين الوصفات والأدوية من خلال إنشاء جدول وسيط PrescriptionDetails يحتوي على مفاتيح أجنبية تشير إلى كل من الوصفات والأدوية، بالإضافة إلى معلومات إضافية مثل الجرعة والتكرار والمدة والكمية.

2. **الفواتير وبنود الفواتير**: تم حل العلاقة بين الفواتير وبنود الفواتير المتعددة من خلال إنشاء جدول BillDetails الذي يربط كل فاتورة ببنود متعددة.

## قيود السلامة المرجعية (Referential Integrity Constraints)

1. لا يمكن حذف مريض إذا كان لديه مواعيد أو إقامات أو وصفات أو نتائج فحوصات أو فواتير مرتبطة به.
2. لا يمكن حذف طبيب إذا كان لديه مواعيد أو إقامات أو وصفات أو نتائج فحوصات مرتبطة به، أو إذا كان رئيساً لقسم.
3. لا يمكن حذف قسم إذا كان هناك أطباء أو ممرضون أو غرف مرتبطة به.
4. لا يمكن حذف غرفة إذا كانت هناك إقامات مرتبطة بها.
5. لا يمكن حذف دواء إذا كان هناك وصفات مرتبطة به.
6. لا يمكن حذف فحص إذا كانت هناك نتائج فحوصات مرتبطة به.
7. لا يمكن حذف وصفة إذا كانت هناك تفاصيل وصفة مرتبطة بها.
8. لا يمكن حذف فاتورة إذا كانت هناك تفاصيل فاتورة مرتبطة بها.

## ملاحظات إضافية

1. تم استخدام المفاتيح المركبة في جداول PrescriptionDetails وBillDetails لتمثيل العلاقات متعددة إلى متعددة بشكل صحيح.
2. تم تصميم النموذج العلائقي بحيث يدعم الاستعلامات المعقدة مثل:
   - البحث عن جميع المرضى الذين عالجهم طبيب معين.
   - حساب إجمالي الإيرادات حسب القسم أو الطبيب.
   - تتبع استخدام الأدوية والفحوصات.
   - تحليل معدلات الإشغال للغرف.
3. يمكن إضافة قيود إضافية مثل CHECK لضمان صحة البيانات (مثل التحقق من أن تاريخ الخروج لا يسبق تاريخ الدخول في جدول الإقامة).
