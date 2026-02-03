# ❄️ Andrewix - NixOS Dendritic Configuration

Cấu hình NixOS và Home Manager cá nhân của Andrew, được thiết kế theo kiến trúc **Dendritic** (dạng cây) giúp tự động hóa việc quản lý module và tối ưu hóa khả năng mở rộng.

## 🚀 Tính năng nổi bật
- **Auto-importing**: Tự động nhận diện và nạp các file `.nix` mới trong thư mục `features/` nhờ `import-tree`.
- **Hybrid Config**: Kết hợp mượt mà giữa cấu hình hệ thống (NixOS) và cấu hình người dùng (Home Manager) trong cùng một module.
- **Dendritic Architecture**: Chia nhỏ cấu hình thành các "Aspects" (khía cạnh) như `base`, `system`, `desktop`, `apps`, `dev`.
- **Global Parameterization**: Dễ dàng thay đổi font, username, mount path thông qua các biến toàn cục.

---

## 🏗️ Cấu trúc thư mục
```text
~/dotconfigs/
├── aspects/           # Logic chính & các tính năng (được phân loại)
│   ├── base/          # Cài đặt cốt lõi (locale, fonts, security)
│   ├── system/        # Dịch vụ hệ thống (docker, networking, audio)
│   ├── desktop/       # Giao diện (Hyprland, Waybar, Themes)
│   ├── apps/          # Ứng dụng người dùng (browsers, tools)
│   └── dev/           # Công cụ lập trình (git, nvim, compilers)
├── hosts/             # Định nghĩa phần cứng & danh sách máy (PC, Laptop)
├── users/             # Danh tính người dùng (Andrew) & Home Manager entrypoint
├── lib/               # Helper functions (mksystem builder)
└── flake.nix          # Điểm khởi đầu của toàn bộ cấu hình
```

---

## 💻 Cài đặt cho máy mới (Bootstrap)

1. **Chuẩn bị NixOS**: Cài đặt NixOS với flake support được bật.
2. **Clone repository**:
   ```bash
   git clone https://github.com/Andrew/dotconfigs.git ~/dotconfigs
   cd ~/dotconfigs
   ```
3. **Xác định hostname**: Kiểm tra hoặc tạo cấu hình phần cứng trong `hosts/<hostname>/`.
4. **Áp dụng cấu hình**:
   ```bash
   # Sử dụng nh (Nix Helper) để cài đặt
   nh os switch .
   ```

---

## 🛠️ Quy trình thêm tính năng mới (Adding New)

Nhờ kiến trúc `import-tree`, bạn không cần khai báo file mới trong danh sách `imports`.

1. **Chọn thư mục phù hợp**: Ví dụ muốn thêm cấu hình cho `spotify`, hãy vào `aspects/apps/features/`.
2. **Tạo file mới**: `spotify.nix`.
3. **Viết nội dung**:
   ```nix
   { pkgs, username, ... }: {
     # Cài đặt package cho hệ thống
     environment.systemPackages = [ pkgs.spotify ];

     # Cấu hình Home Manager cho người dùng andrew
     home-manager.users.${username}.programs.spotify-player.enable = true;
   }
   ```
4. **Kiểm tra và áp dụng**:
   ```bash
   nix flake check && nh os switch .
   ```

---

## ⚙️ Hướng dẫn Override & Parameterization

Các tham số quan trọng được định nghĩa tập trung tại `hosts/default.nix` và truyền qua `specialArgs`:

- **Thay đổi Font**: Sửa `fontFamily` trong `hosts/default.nix`.
- **Thay đổi đường dẫn Mount Drive**: Sửa `driveMountPath` (mặc định: `/home/andrew/mnt/gdrive`).
- **Override Host-specific**: Nếu một cấu hình chỉ dành riêng cho 1 máy, hãy đặt nó trong `hosts/<hostname>/default.nix` thay vì trong `aspects/`.

---

## 📝 Lệnh quản lý thường dùng

| Lệnh | Mục đích |
| :--- | :--- |
| `nh os switch .` | Áp dụng thay đổi ngay lập tức |
| `nh os switch . --dry-run` | Xem trước các thay đổi (nên dùng khi sửa cấu hình lớn) |
| `nix flake check` | Kiểm tra lỗi cú pháp và logic toàn bộ flake |
| `nixfmt .` | Tự động định dạng code theo chuẩn |
| `nh clean all` | Dọn dẹp các bản build cũ và rác trong nix store |

---

## 🛡️ Tài liệu cho Agent
Nếu bạn là một AI Agent (như Serena hoặc Copilot), vui lòng đọc kỹ **[AGENTS.md](AGENTS.md)** để nắm rõ các quy tắc lập trình, quy ước đặt tên và luồng làm việc đặc thù của repository này.
