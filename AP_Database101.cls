/*************************************************************
 * @author : th.kim
 * @date : 2024-06-04
 * @description : Apex Problems - Database 101
 * @target : 
==============================================================
 * Ver          Date            Author          Modification
 * 1.0          2024-06-04      th.kim          Initial Version
**************************************************************/
public with sharing class AP_Database101 {

    /**
     * @author th.kim
     * @description name, email 데이터로 Student 레코드 생성 및 Id 반환
     * @param name name
     * @param email email
     *
     * @return Student Record Id
     */
    public Id insertStudent(String name, String email) {
        apxio__Student__c student = new apxio__Student__c(
                Name = name,
                apxio__Email__c = email
        );
        insert student;
        return student.Id;
    }

    /**
     * @author th.kim
     * @description Course__c 레코드 생성 및 Credits__c 픽리스트 값 체크
     * @param name name
     * @param details details
     * @param credits credits
     *
     * @return 생성된 레코드 Id 값
     */
    public Id insertCourse(String name, String details, Integer credits) {
        try {
            // 크레딧이 유효한 범위 내에 있는지 확인
            if (credits >= 0 && credits < 5) {
                // 코스 객체 생성 및 필드 값 설정
                apxio__Course__c objCourse = new apxio__Course__c(
                        Name = name,
                        apxio__Course_Details__c = details,
                        apxio__Credits__c = String.valueOf(credits)
                );
                // 코스 객체 삽입
                insert objCourse;
                // 삽입된 코스 객체의 ID 반환
                return objCourse.Id;
            }
            // 크레딧이 유효하지 않은 경우 null 반환
            return null;
        } catch (Exception e) {
            // 예외 발생 시 null 반환
            return null;
        }
    }

    /**
     * @author th.kim
     * @description Student 레코드 생성 후 자동번호 데이터 가져오기
     * @param name name
     * @param phone phone
     * @param email email
     *
     * @return 생성된 레코드의 apxio__Registration_Number__c 값
     */
    public String registerStudent(String name, String phone, String email) {
        try {
            apxio__Student__c objStudent = new apxio__Student__c(
                    Name = name,
                    apxio__Phone__c = phone,
                    apxio__Email__c = email
            );
            // 레코드 생성
            insert objStudent;

            // 생성 된 Student 레코드로 apxio__Registration_Number__c 조회
            apxio__Student__c objStudentAfter = [SELECT apxio__Registration_Number__c FROM apxio__Student__c WHERE Id = :objStudent.Id LIMIT 1];
            return objStudentAfter.apxio__Registration_Number__c;

        } catch (Exception e) {
            // 예외 발생 시 null 반환
            return null;
        }
    }

    /**
     * @author th.kim
     * @description 활성화 되어있는 Student 리스트 불러오기
     * @return 활성화 되어있는 Student 리스트
     */
    public List<apxio__Student__c> selectActiveStudents() {
        try {
            List<apxio__Student__c> listStudent = [SELECT Id, Name FROM apxio__Student__c WHERE apxio__Active__c = TRUE];
            return listStudent;
        } catch (QueryException e) {
            // Query 예외 발생 시 null 반환
            return null;
        }
    }

    /**
     * @author th.kim
     * @description 활성화 되어있고, Phone, Email 데이터가 누락되어있는 Student 리스트 가져오기
     * @return 활성화 되어있고, Phone, Email 데이터가 누락되어있는 Student 리스트
     */
    public List<apxio__Student__c> selectUnreachableStudents() {
        try {
            List<apxio__Student__c> listStudent = [
                    SELECT Id, Name, apxio__Phone__c, apxio__Email__c, apxio__Active__c
                    FROM apxio__Student__c
                    WHERE apxio__Active__c = TRUE
                    AND apxio__Phone__c = NULL
                    AND apxio__Email__c = NULL
                    ORDER BY Name
            ];
            return listStudent;
        } catch (QueryException e) {
            // Query 예외 발생 시 null 반환
            return null;
        }
    }

    /**
     * @author th.kim
     * @description 활성화 되어있고, Phone이나 Email 데이터가 누락되어있는 Student 리스트 가져오기
     * @return 활성화 되어있고, Phone이나 Email 데이터가 누락되어있는 Student 리스트
     */
    public List<apxio__Student__c> selectStudentsWithoutContactInfo() {
        try {
            List<apxio__Student__c> listStudent = [
                    SELECT Id, Name, apxio__Phone__c, apxio__Email__c, apxio__Active__c
                    FROM apxio__Student__c
                    WHERE apxio__Active__c = TRUE
                    AND (apxio__Phone__c = NULL OR apxio__Email__c = NULL)
                    ORDER BY Name
            ];
            return listStudent;
        } catch (QueryException e) {
            // Query 예외 발생 시 null 반환
            return null;
        }
    }

    /**
     * @author th.kim
     * @description Course 레코드를 생성하고 하위 개체인 Class 생성 시 apxio__Description__c 255자 제한하여 생성
     * @param name name
     * @param description description
     */
    public void createCourseAndClass(String name, String description) {
        if (String.isNotBlank(name)) {
            description = String.isNotBlank(description) ? description : '';
            apxio__Course__c objCourse = new apxio__Course__c(
                    Name = name,
                    apxio__Course_Details__c = description
            );
            insert objCourse;

            apxio__Class__c objClass = new apxio__Class__c(
                    apxio__Course__c = objCourse.Id,
                    Name = name,
                    apxio__Description__c = description.length() > 255 ? description.substring(0, 255) : description
            );
            insert objClass;
        }
    }

    /**
     * @author th.kim
     * @description 두 목록이 항상 같은 크기를 가질 때 순서대로 생성
     * @param studentNames studentName 리스트
     * @param studentEmails studentEmail 리스트
     */
    public void insertStudents(List<String> studentNames, List<String> studentEmails) {
        List<apxio__Student__c> listStudent = new List<apxio__Student__c>();

        for (Integer i = 0; i < studentNames.size(); i++) {
            listStudent.add(new apxio__Student__c(
                    Name = studentNames[i],
                    apxio__Email__c = studentEmails[i]
            ));
        }

        if (!listStudent.isEmpty()) insert listStudent;
    }

    /**
     * @author th.kim
     * @description 주어진 courseName에 해당하는 apxio__Course__c로 apxio__Class__c를 생성, apxio__Course__c 존재하지 않을 시 null 반환
     * @param courseName courseName
     *
     * @return apxio__Class__c.Id || null
     */
    public Id classFromCourse(String courseName) {
        try {
            apxio__Course__c objCourse = [SELECT Id FROM apxio__Course__c WHERE Name = :courseName LIMIT 1];
            apxio__Class__c objClass = new apxio__Class__c(
                    Name = courseName,
                    apxio__Course__c = objCourse.Id
            );
            insert objClass;
            return objClass.Id;
        } catch (QueryException e) {
            // 예외 시 null 반환
            return null;
        }
    }

    /**
     * @author th.kim
     * @description 주어진 Student의 emails과 className으로 apxio__Class_Enrollment__c 생성
     * @param emails emails
     * @param className className
     */
    public void enrollStudents(List<String> emails, String className) {
        List<apxio__Student__c> listStudent = [SELECT Id FROM apxio__Student__c WHERE apxio__Email__c IN :emails];
        apxio__Class__c objClass = [SELECT Id FROM apxio__Class__c WHERE Name = :className];

        List<apxio__Class_Enrollment__c> listClassEnroll = new List<apxio__Class_Enrollment__c>();
        for(apxio__Student__c objStudent : listStudent) {
            listClassEnroll.add(new apxio__Class_Enrollment__c(apxio__Student__c = objStudent.Id, apxio__Offered_Class__c = objClass.Id));
        }
        if(!listClassEnroll.isEmpty()) insert listClassEnroll;
    }
}