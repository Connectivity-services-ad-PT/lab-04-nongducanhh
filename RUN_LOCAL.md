# Hướng dẫn khởi chạy Service (Lab 04)

Dưới đây là 3 bước đơn giản để khởi chạy service bằng Docker trên môi trường local.

**Yêu cầu:** Máy tính đã cài đặt sẵn Docker Desktop / Docker Engine.

### Bước 1: Build Docker Image
Mở terminal tại thư mục gốc của project và chạy lệnh sau để đóng gói service:
`docker build -t fit4110/iot-ingestion:lab04 .`

### Bước 2: Chạy Docker Container
Khởi chạy service ngầm ở cổng 8000:
`docker run -d --rm --name fit4110-iot-lab04 -p 8000:8000 --env-file .env.example fit4110/iot-ingestion:lab04`

### Bước 3: Kiểm tra sức khỏe (Healthcheck)
Đảm bảo service đã hoạt động bình thường:
`curl http://localhost:8000/health`
*(Nếu kết quả trả về có `"status":"ok"` là thành công).*