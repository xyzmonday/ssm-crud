package com.yff.entity;

/**
 * 增强Employee，将部门信息增加到员工里面
 */
public class EmployeeCustom extends Employee {

    private Department department;

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }
}
