    create table account (
        account_id integer not null auto_increment,
        avail_balance float,
        close_date date,
        last_activity_date date,
        open_date date not null,
        pending_balance float,
        status varchar(10),
        cust_id integer,
        open_branch_id integer not null,
        open_emp_id integer not null,
        product_cd varchar(10) not null,
        primary key (account_id)
    );

    create table acc_transaction (
        txn_id bigint not null auto_increment,
        amount float not null,
        funds_avail_date datetime not null,
        txn_date datetime not null,
        txn_type_cd varchar(10),
        account_id integer,
        execution_branch_id integer,
        teller_emp_id integer,
        primary key (txn_id)
    );

    create table branch (
        branch_id integer not null auto_increment,
        address varchar(30),
        city varchar(20),
        name varchar(20) not null,
        state varchar(10),
        zip_code varchar(12),
        primary key (branch_id)
    );

    create table business (
        incorp_date date,
        name varchar(255) not null,
        state_id varchar(10) not null,
        cust_id integer not null,
        primary key (cust_id)
    );

    create table customer (
        cust_id integer not null auto_increment,
        address varchar(30),
        city varchar(20),
        cust_type_cd varchar(1) not null,
        fed_id varchar(12) not null,
        postal_code varchar(10),
        state varchar(20),
        primary key (cust_id)
    );

    create table department (
        dept_id integer not null auto_increment,
        name varchar(20) not null,
        primary key (dept_id)
    );

    create table employee (
        emp_id integer not null auto_increment,
        end_date date,
        first_name varchar(20) not null,
        last_name varchar(20) not null,
        start_date date not null,
        title varchar(20),
        assigned_branch_id integer,
        dept_id integer,
        superior_emp_id integer,
        primary key (emp_id)
    );

    create table individual (
        birth_date date,
        first_name varchar(30) not null,
        last_name varchar(30) not null,
        cust_id integer not null,
        primary key (cust_id)
    );

    create table officer (
        officer_id integer not null auto_increment,
        end_date date,
        first_name varchar(30) not null,
        last_name varchar(30) not null,
        start_date date not null,
        title varchar(20),
        cust_id integer,
        primary key (officer_id)
    );

    create table product (
        product_cd varchar(10) not null,
        date_offered date,
        date_retired date,
        name varchar(50) not null,
        product_type_cd varchar(255),
        primary key (product_cd)
    );

    create table product_type (
        product_type_cd varchar(255) not null,
        name varchar(50),
        primary key (product_type_cd)
    );

    alter table account 
        add constraint account_customer_fk 
        foreign key (cust_id) 
        references customer (cust_id);

    alter table account 
        add constraint account_branch_fk 
        foreign key (open_branch_id) 
        references branch (branch_id);

    alter table account 
        add constraint account_employee_fk 
        foreign key (open_emp_id) 
        references employee (emp_id);

    alter table account 
        add constraint account_product_fk 
        foreign key (product_cd) 
        references product (product_cd);

    alter table acc_transaction 
        add constraint acc_transaction_account_fk 
        foreign key (account_id) 
        references account (account_id);

    alter table acc_transaction 
        add constraint acc_transaction_branch_fk 
        foreign key (execution_branch_id) 
        references branch (branch_id);

    alter table acc_transaction 
        add constraint acc_transaction_employee_fk 
        foreign key (teller_emp_id) 
        references employee (emp_id);

    alter table business 
        add constraint business_employee_fk 
        foreign key (cust_id) 
        references customer (cust_id);

    alter table employee 
        add constraint employee_branch_fk 
        foreign key (assigned_branch_id) 
        references branch (branch_id);

    alter table employee 
        add constraint employee_department_fk 
        foreign key (dept_id) 
        references department (dept_id);

    alter table employee 
        add constraint employee_employee_fk 
        foreign key (superior_emp_id) 
        references employee (emp_id);

    alter table individual 
        add constraint individual_customer_fk 
        foreign key (cust_id) 
        references customer (cust_id);

    alter table officer 
        add constraint officer_customer_fk 
        foreign key (cust_id) 
        references customer (cust_id);

    alter table product 
        add constraint product_product_type_fk 
        foreign key (product_type_cd) 
        references product_type (product_type_cd);

