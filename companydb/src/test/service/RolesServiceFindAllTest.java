package test.service;

import ioc.IoCConfigurer;
import ioc.IoCContainer;
import ioc.IoCException;
import pool.ConnectionPool;
import pool.PoolException;

import java.util.List;

import service.RolesService;
import service.ServiceException;
import test.Utility;
import company.Roles;

public class RolesServiceFindAllTest {
    public static void main(String[] args) throws IoCException, ServiceException, PoolException {
        ConnectionPool.getInstance().init("com.mysql.cj.jdbc.Driver", "jdbc:mysql://localhost:3306/companydb?useUnicode=true&characterEncoding=UTF8&useSSL=false&allowPublicKeyRetrieval=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "1234");
        IoCConfigurer.configure();
        try(IoCContainer ioc = new IoCContainer()) {
            RolesService roleService = ioc.get(RolesService.class);
            List<Roles> roles = roleService.findAll();
            System.out.println("Список всех ролей");
            System.out.println("===================");
            for(Roles role : roles) {
                System.out.println(Utility.toString(role));
            }
        } finally {
            ConnectionPool.getInstance().destroy();
        }
    }
}