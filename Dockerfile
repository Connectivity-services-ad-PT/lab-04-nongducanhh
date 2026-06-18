# 1. Chọn hệ điều hành nền Python cực nhẹ
FROM python:3.10-slim

# 2. Cài đặt curl để xài cho lệnh HEALTHCHECK (kiểm tra sức khỏe app)
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# 3. Chuyển vào thư mục làm việc chính
WORKDIR /app

# 4. Copy file thư viện vào và cài đặt (làm trước để tận dụng cache)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copy toàn bộ mã nguồn của nhóm vào container
COPY src/ ./src/

# 6. YÊU CẦU BẮT BUỘC: Tạo non-root user để tăng tính bảo mật
RUN useradd -m appuser && chown -R appuser:appuser /app
USER appuser

# 7. Mở cổng 8000 để bên ngoài gọi vào được
EXPOSE 8000

# 8. YÊU CẦU BẮT BUỘC: Cấu hình bắt mạch tự động cho service
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8000/health || exit 1

# 9. Lệnh khởi động app khi Container chạy
CMD ["uvicorn", "iot_app.main:app", "--app-dir", "src", "--host", "0.0.0.0", "--port", "8000"]