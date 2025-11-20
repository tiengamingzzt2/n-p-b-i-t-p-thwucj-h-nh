create database quan_ly_tt_san_bay;
use quan_ly_tt_san_bay;

-- phần 2 --

create table Flight (
	flight_id char(10) primary key,
    airline_name varchar(100),
    departure_airport varchar (100),
    arrival_airport varchar (100),
    departure_time timestamp,
    arrival_time timestamp,
	ticket_price float
);



create table Passenger (
	passenger_id char(10) primary key,
    passenger_full_name varchar(150) not null,
    passenger_email varchar(255) unique,
    passenger_phone varchar(15) unique,
    passenger_bod date
);


create table Booking (
	booking_id int primary key auto_increment,
    passenger_id char(10),
    foreign key (passenger_id) references Passenger(passenger_id),
    flight_id char(10),
    foreign key (flight_id) references Flight (flight_id),
    booking_date date,
    booking_status enum ('Confirmed', "Cancelled", 'Pending')
);

create table Payment (
	 payment_id int primary key auto_increment,
     booking_id int,
     foreign key (booking_id) references booking(booking_id),
     payment_method enum ("Credit Card", "Bank Transfer", "Cash"),
     payment_amount float,
     payment_date date,
     payment_status enum( "Success", "Failed", "Pending")

);

-- 2. Thêm cột passenger_gender có kiểu dữ liệu là enum với các giá trị 'Nam', 'Nữ', 'Khác' trong bảng Passenger --

alter table Passenger
add passenger_gender enum ('Nam', 'Nữ', 'Khác');


-- 3. Thêm cột ticket_quantity trong bảng Booking có kiểu dữ liệu là integer, có rằng buộc NOT NULL và giá trị mặc định là 1. Cột này thể hiện số lượng vé mà hành khách đã đặt --

alter table Booking
add ticket_quantity int not null default(1);


-- 4. Thêm rằng buộc cho cột payment_amount trong bảng Payment phải có giá trị lớn hơn 0 và có kiểu dữ liệu là DECIMAL(10, 2) --

alter table Payment
modify column payment_amount decimal(10,2) check(payment_amount >0) ;

-- phần 3 --

insert into Passenger
values
('P0001' ,'Nguyen Anh Tuan' ,'tuan.nguyen@example.com',0901234567 ,'1995-05-15 ','Nam'),
('P0002','Tran Thi Mai','mai.tran@example.com ',0912345678,'1996-06-16','Nu'),
('P0003','Le Minh Tuan ', 'tuan.le@example.com',0923456789 ,'1997-07-17 ','Nam'),
('P0004', 'Pham Hong Son', 'son.pham@example.com', '0934567890', '1998-08-18', 'Nam'),
('P0005', 'Nguyen Thi Lan', 'lan.nguyen@example.com', '0945678901', '1999-09-19', 'Nu'),
('P0006', 'Vu Thi Bao', 'bao.vu@example.com', '0956789012', '2000-10-20', 'Nu'),
('P0007', 'Doan Minh Hoang', 'hoang.doan@example.com', '0967890123', '2001-11-21', 'Nam'),
('P0008', 'Nguyen Thi Thanh', 'thanh.nguyen@example.com', '0978901234', '2002-12-22', 'Nu'),
('P0009', 'Trinh Bao Vy', 'vy.trinh@example.com', '0989012345', '2003-01-23', 'Nu'),
('P0010', 'Bui Hoang Nam', 'nam.bui@example.com', '0990123456', '2004-02-24', 'Nam');

INSERT INTO Flight 
 VALUES
('F001', 'Vietjet Air', 'Tan Son Nhat', 'Nha Trang', '2025-03-01 08:00:00', '2025-03-01 10:00:00', 150.50),
('F002', 'Vietnam Airlines', 'Noi Bai', 'Hanoi', '2025-03-01 09:00:00', '2025-03-01 11:30:00', 200.00),
('F003', 'Bamboo Airways', 'Da Nang', 'Phu Quoc', '2025-03-01 10:00:00', '2025-03-01 12:00:00', 120.80),
('F004', 'Vietravel Airlines', 'Can Tho', 'Ho Chi Minh', '2025-03-01 11:00:00', '2025-03-01 12:30:00', 180.00);


INSERT INTO Booking 
 VALUES
(1, 'P0001', 'F001', '2025-02-20', 'Confirmed', 1),
(2, 'P0002', 'F002', '2025-02-21', 'Cancelled', 2),
(3, 'P0003', 'F003', '2025-02-22', 'Pending', 1),
(4, 'P0004', 'F004', '2025-02-23', 'Confirmed', 3),
(5, 'P0005', 'F001', '2025-02-24', 'Pending', 1),
(6, 'P0006', 'F002', '2025-02-25', 'Confirmed', 2),
(7, 'P0007', 'F003', '2025-02-26', 'Cancelled', 1),
(8, 'P0008', 'F004', '2025-02-27', 'Pending', 4),
(9, 'P0009', 'F001', '2025-02-28', 'Confirmed', 1),
(10, 'P0010', 'F002', '2025-02-28', 'Pending', 1),
(11, 'P0001', 'F003', '2025-03-01', 'Confirmed', 3),
(12, 'P0002', 'F004', '2025-03-01', 'Cancelled', 1),
(13, 'P0003', 'F001', '2025-03-03', 'Pending', 2),
(14, 'P0004', 'F002', '2025-03-04', 'Confirmed', 1),
(15, 'P0005', 'F003', '2025-03-05', 'Cancelled', 2),
(16, 'P0006', 'F004', '2025-03-06', 'Pending', 1),
(17, 'P0007', 'F001', '2025-03-07', 'Confirmed', 3),
(18, 'P0008', 'F002', '2025-03-08', 'Cancelled', 2),
(19, 'P0009', 'F003', '2025-03-09', 'Pending', 1),
(20, 'P0010', 'F004', '2025-03-10', 'Confirmed', 1);

INSERT INTO Payment 
 VALUES
(1, 1, 'Credit Card', 150.50, '2025-02-20', 'Success'),
(2, 2, 'Bank Transfer', 200.00, '2025-02-21', 'Failed'),
(3, 3, 'Cash', 120.80, '2025-02-22', 'Pending'),
(4, 4, 'Credit Card', 180.00, '2025-02-23', 'Success'),
(5, 5, 'Bank Transfer', 150.50, '2025-02-24', 'Pending'),
(6, 6, 'Cash', 200.00, '2025-02-25', 'Success'),
(7, 7, 'Credit Card', 120.80, '2025-02-26', 'Failed'),
(8, 8, 'Bank Transfer', 180.00, '2025-02-27', 'Pending'),
(9, 9, 'Cash', 150.50, '2025-02-28', 'Success'),
(10, 10, 'Credit Card', 200.00, '2025-03-01', 'Pending');


SET SQL_SAFE_UPDATES = 0;

-- Cập nhật trạng thái thanh toán thành "Success" nếu số tiền thanh toán (payment_amount) > 0 và phương thức thanh toán là "Credit Card". --

update Payment
set payment_status = ("Success")
where payment_amount > 0 and payment_method =( "Credit Card");

-- Cập nhật trạng thái thanh toán thành "Pending" nếu phương thức thanh toán là "Bank Transfer" và số tiền thanh toán nhỏ hơn 100.--

update Payment
set payment_status = ("Pending")
where payment_amount < 100 and payment_method =( "Bank Transfer");

-- Chỉ cập nhật trạng thái thanh toán cho những giao dịch có ngày thanh toán (payment_date) là trước ngày hiện tại(CURRENT_DATE)--

update Payment
set payment_status = ("Pending")
where payment_date < CURRENT_DATE ;

-- Xóa các bản ghi trong bảng Payment nếu trạng thái thanh toán là "Pending" và phương thức thanh toán là "Cash".--

delete from payment
where payment_status ="Pending" and payment_method =  "Cash";

-- phần 4

-- 1. Lấy thông tin 5 hành khách gồm mã, tên, email, ngày sinh, và giới tính, sắp xếp theo tên hành khách tăng dần--

select r.passenger_id ,r.passenger_full_name, r.passenger_email , r.passenger_bod
from Passenger r
order by r.passenger_full_name asc;

-- 2. Lấy thông tin các chuyến bay gồm mã, tên hãng hàng không, sân bay khởi hành và sân bay đến, sắp xếp theo giá vé giảm dần--

select s.flight_id, s.airline_name , s.departure_airport ,s.arrival_airport, s.ticket_price
from Flight s
order by s.ticket_price desc;

-- 3. Lấy thông tin các hành khách gồm mã hành khách, tên hành khách, chuyến bay đã đặt và trạng thái vé là "Cancelled" --

select r.passenger_id , r.passenger_full_name , b.booking_id ,b.booking_status
from Passenger r join Booking b on r.passenger_id = b.passenger_id
where b.booking_status = "Cancelled";

-- 4. Lấy danh sách các chuyến bay gồm mã vé, mã hành khách, chuyến bay đã đặt, và số lượng vé cho các chuyến bay có trạng thái "Confirmed", sắp xếp theo số lượng vé giảm dần

SELECT booking_id, passenger_id,flight_id,ticket_quantity
FROM Booking
WHERE booking_status = 'Confirmed' 
ORDER BY ticket_quantity DESC;

