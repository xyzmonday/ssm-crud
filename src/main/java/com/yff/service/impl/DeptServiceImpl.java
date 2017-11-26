package com.yff.service.impl;

import com.yff.dao.DepartmentMapper;
import com.yff.entity.Department;
import com.yff.service.DeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DeptServiceImpl implements DeptService {

    @Autowired
    private DepartmentMapper departmentMapper;

    @Override
    public List<Department> getDepartmentList() {
        List<Department> departments = departmentMapper.selectByExample(null);
        return departments;
    }
}
