using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace KobePaint.App_Code
{
    #region Nhập hàng
    [Serializable]


    public class oImportProduct_ChiTietNhapHang
    {
        public int STT { get; set; }
        public int IDHangHoa { get; set; }
        public string MaHang { get; set; }
        public string TenHangHoa { get; set; }
        public double GiaVon { get; set; }
        public int TonKho { get; set; }
        public int SoLuong { get; set; }
        public double ThanhTien { get; set; }
        public double GiaBanMoi { get; set; }
        public double GiaBanCu { get; set; }
        public oImportProduct_ChiTietNhapHang(int iDHangHoa, string maHang, string tenHangHoa, double giaVon, int tonKho, int soLuong, double thanhTien, double giaBanMoi, double giaBanCu)
        {
            // TODO: Complete member initialization
            this.IDHangHoa = iDHangHoa;
            this.MaHang = maHang;
            this.TenHangHoa = tenHangHoa;
            this.GiaVon = giaVon;
            this.TonKho = tonKho;
            this.SoLuong = soLuong;
            this.ThanhTien = thanhTien;
            this.GiaBanMoi = giaBanMoi;
            this.GiaBanCu = giaBanCu;
        }
    }
    #endregion

    #region Xuất khác
    [Serializable]
    public class oImportProduct_ChiTietXuatKhac
    {
        public int STT { get; set; }
        public int IDHangHoa { get; set; }
        public string MaHang { get; set; }
        public string TenHangHoa { get; set; }
        public double GiaVon { get; set; }
        public int TonKho { get; set; }
        public int SoLuong { get; set; }
        public double ThanhTien { get; set; }
        public int LyDoXuatID { get; set; }

        public oImportProduct_ChiTietXuatKhac(int iDHangHoa, string maHang, string tenHangHoa, double giaVon, int tonKho, int soLuong, double thanhTien, int lyDoXuatID)
        {
            // TODO: Complete member initialization
            this.IDHangHoa = iDHangHoa;
            this.MaHang = maHang;
            this.TenHangHoa = tenHangHoa;
            this.GiaVon = giaVon;
            this.TonKho = tonKho;
            this.SoLuong = soLuong;
            this.ThanhTien = thanhTien;
            this.LyDoXuatID = lyDoXuatID;
        }
    }
    #endregion


    #region Kiểm kê
    [Serializable]
    public class oImportProduct_ChiTietKiemKe
    {
        public int STT { get; set; }
        public int IDHangHoa { get; set; }
        public string MaHang { get; set; }
        public string TenHangHoa { get; set; }
        public int TonKhoHeThong { get; set; }
        public int TonKhoThucTe { get; set; }
        public int ChenhLech { get; set; }
        public int TrangThai { get; set; }
        public string DienGiai { get; set; }

        public oImportProduct_ChiTietKiemKe(int iDHangHoa, string maHang, string tenHangHoa, int tonKhoHeThong, int tonKhoThucTe, int chenhLech, int trangThai, string dienGiai)
        {
            // TODO: Complete member initialization
            this.IDHangHoa = iDHangHoa;
            this.MaHang = maHang;
            this.TenHangHoa = tenHangHoa;
            this.TonKhoHeThong = tonKhoHeThong;
            this.TonKhoThucTe = tonKhoThucTe;
            this.ChenhLech = chenhLech;
            this.TrangThai = trangThai;
            this.DienGiai = dienGiai;
        }
    }
    #endregion

    #region Lập phiếu giao hàng
    [Serializable]
    public class LapPhieuGiaohang
    {
        public int STT { get; set; }
        public int IDHangHoa { get; set; }
        public string MaHang { get; set; }
        public string TenHangHoa { get; set; }
        public string TenDonViTinh { get; set; }
        public double GiaVon { get; set; }
        public int TonKho { get; set; }
        public int SoLuong { get; set; }
        public double ThanhTien { get; set; }
        public double GiaBan { get; set; }
        public LapPhieuGiaohang(int iDHangHoa, string maHang, string tenHangHoa, double giaVon, int tonKho, int soLuong, double thanhTien, double giaBan, string tenDonViTinh)
        {
            // TODO: Complete member initialization
            this.IDHangHoa = iDHangHoa;
            this.MaHang = maHang;
            this.TenHangHoa = tenHangHoa;
            this.GiaVon = giaVon;
            this.TonKho = tonKho;
            this.SoLuong = soLuong;
            this.ThanhTien = thanhTien;
            this.GiaBan = giaBan;
            this.TenDonViTinh = tenDonViTinh;
        }
    }
    #endregion



    #region Trả hàng NCC
    [Serializable]
    public class oImportProduct_TraHangNCC
    {
        public int STT { get; set; }
        public int IDHangHoa { get; set; }
        public string MaHang { get; set; }
        public string TenHangHoa { get; set; }
        public string TenDonViTinh { get; set; }
        public double GiaVon { get; set; }
        public int TonKho { get; set; }
        public int SoLuong { get; set; }
        public double ThanhTien { get; set; }
        public double TienTra { get; set; }

        public oImportProduct_TraHangNCC(int iDHangHoa, string maHang, string tenHangHoa, double giaVon, int tonKho, int soLuong, double thanhTien, double tienTra, string tenDonViTinh)
        {
            // TODO: Complete member initialization
            this.IDHangHoa = iDHangHoa;
            this.MaHang = maHang;
            this.TenHangHoa = tenHangHoa;
            this.GiaVon = giaVon;
            this.TonKho = tonKho;
            this.SoLuong = soLuong;
            this.ThanhTien = thanhTien;
            this.TienTra = tienTra;
            this.TenDonViTinh = tenDonViTinh;
        }
    }
    #endregion


    #region report giao hàng
    [Serializable]
    public class oReportGiaoHang
    {
        public int IDPhieuGiaoHang { get; set; }
        public string NgayTao { get; set; }
        public string MaPhieu { get; set; }
        public int NhanVienID { get; set; }
        public string GhiChuGiaoHang { get; set; }
        public int KhachHangID { get; set; }
        public string NgayGiao { get; set; }
        public string NguoiGiao { get; set; }
        public string DiaChiGiaoHang { get; set; }
        public int TongSoLuong { get; set; }
        public double TongTien { get; set; }
        public string DienThoai { get; set; }
        public string SoHoaDon { get; set; }
        public double ThanhToan { get; set; }
        public double ConLai { get; set; }
        public string MaKhachHang { get; set; }
        public string TenKhachHang { get; set; }
        public string TenNhanVien { get; set; }
        public string SoDonHangTrongNam { get; set; }
        public double CongNoHienTai { get; set; }
        public string TieuDePhieu { get; set; }
        public string TrangThaiPhieu { get; set; }
        public double GiamGia { get; set; }
        public List<oProduct> listProduct { get; set; }
    }
    [Serializable]
    public class oProduct
    {
        public int STT { get; set; }
        public string MaHang { get; set; }
        public string TenHang { get; set; }
        public string TenDonViTinh { get; set; }
        public int SoLuong { get; set; }
        public double DonGia { get; set; }
        public double ThanhTien { get; set; }


        public oProduct(string maHang,string tenHang,string tenDonViTinh,int soLuong, float donGia)
        {
            // TODO: Complete member initialization
            this.MaHang = maHang;
            this.TenHang = tenHang;
            this.TenDonViTinh = tenDonViTinh;
            this.SoLuong = soLuong;
            this.DonGia = donGia;
            this.ThanhTien = this.SoLuong * this.DonGia;
        }

        public oProduct()
        {
            // TODO: Complete member initialization
        }

        public oProduct(oProduct x)
        {
            // TODO: Complete member initialization
            this.STT = x.STT;
            this.MaHang = x.MaHang;
            this.TenHang = x.TenHang;
            this.TenDonViTinh = x.TenDonViTinh;
            this.SoLuong = SoLuong;
            this.DonGia = DonGia;
            this.ThanhTien = ThanhTien;
        }
       
    }

    #endregion

    #region phiếu đại lý thanh toán
    public class oThanhToan
    {
        public double CongNoSauThanhToan { get; set; }
        public double CongNoTruocThanhToan { get; set; }
        public double SoTienThu { get; set; }
        public string NoiDung { get; set; }
        public string DienThoai { get; set; }
        public string MaKhachHang { get; set; }
        public string TenKhachHang { get; set; }
        public string SoHoaDon { get; set; }
        public string TieuDe { get; set; }
        public int STTPhieuThu { get; set; }
        public int IDKhachHang { get; set; }
        public string NgayThu { get; set; }
        public string SoTienBangChu { get; set; }
        public string XemTruoc { get; set; }
    }
    #endregion


    #region phiếu thu chi
    public class oThuChi
    {
        public string TieuDe { get; set; }
        public string MaPhieu { get; set; }
        public string Ngay { get; set; }
        public string HoTen { get; set; }
        public string TenNguoiNopNhan { get; set; }
        public string DienThoai { get; set; }
        public string DiaChi { get; set; }
        public string LyDo { get; set; }
        public string NoiDungLyDo { get; set; }
        public double SoTien { get; set; }
        public string NgayThangNam { get; set; }
        public string NguoiNopChi { get; set; }
        public string NguoiThuChi { get; set; }
        public string XemTruoc { get; set; }
    }
    #endregion

    #region bán hàng
    [Serializable]
    public class oChiTietHoaDon
    {
        public int STT { get; set; }
        public string MaHang { get; set; }
        public int IDHangHoa { get; set; }
        public string TenHangHoa { get; set; }
        public string TenDonViTinh { get; set; }
        public int TonKho { get; set; }
        public int SoLuong { get; set; }
        public double GiaBan { get; set; }
        public double GiaVon { get; set; }
        public double ThanhTien { get; set; }
        public double GiamGia { get; set; }
        public double GiaBanCu { get; set; }
        public oChiTietHoaDon(int iDHangHoa, string maHang, string tenHangHoa, string tenDonViTinh, int tonKho, int soLuong, double giaBan, double giaVon, double thanhTien, double giamGia, double giaBanCu)
        {
            this.MaHang = maHang;
            this.IDHangHoa = iDHangHoa;
            this.TenHangHoa = tenHangHoa;
            this.TenDonViTinh = tenDonViTinh;
            this.TonKho = tonKho;
            this.SoLuong = soLuong;
            this.GiaVon = giaVon;
            this.GiaBan = giaBan;
            this.ThanhTien = thanhTien;
            this.GiamGia = giamGia;
            this.GiaBanCu = giaBanCu;
        }
    }
    #endregion

    #region bảng giá
    [Serializable]
    public class oBangGia
    {
        public int STT { get; set; }
        public string MaHang { get; set; }
        public int IDHangHoa { get; set; }
        public string TenHangHoa { get; set; }
        public string TenDonViTinh { get; set; }
        public double GiaVon { get; set; }
        public double DonGiaNhapCuoi { get; set; }
        public double GiaMoi { get; set; }
        public int BangGiaID { get; set; }
        public oBangGia(int iDHangHoa, string maHang, string tenHangHoa, string tenDonViTinh, double giaVon, double donGiaNhapCuoi, double giaMoi, int bangGiaID)
        {
            this.MaHang = maHang;
            this.IDHangHoa = iDHangHoa;
            this.TenHangHoa = tenHangHoa;
            this.TenDonViTinh = tenDonViTinh;
            this.GiaMoi = giaMoi;
            this.DonGiaNhapCuoi = donGiaNhapCuoi;
            this.GiaVon = giaVon;
            this.BangGiaID = bangGiaID;
        }
    }
    #endregion

    #region report giao dịch
    [Serializable]
    public class oReportGiaoDich
    {

        public string TieuDe { get; set; }
        public string MaKhachHang { get; set; }
        public string TenKhachHang { get; set; }
        public string DienThoai { get; set; }
        public string DiaChi { get; set; }
        public double TongPhatSinh { get; set; }
        public double TongHangTra { get; set; }
        public double TongGiamGia { get; set; }
        public double TongThanhToan { get; set; }
        public string NgayThangNam { get; set; }
        public List<oChiTietGiaoDich> listProduct { get; set; }
    }
    [Serializable]
    public class oChiTietGiaoDich
    {
        public int STT { get; set; }
        public string Ngay { get; set; }
        public string NoiDung { get; set; }
        public string SoPhieu { get; set; }
        public double NoDau { get; set; }
        public double NhapHang { get; set; }
        public double HangTra { get; set; }
        public double ThanhToan { get; set; }
        public double NoCuoi { get; set; }
        public double GiamGia { get; set; }
        public oChiTietGiaoDich(int sTT, string ngay, string noiDung, string soPhieu, double noDau, double phatSinh, double hangTra, double thanhToan, double noCuoi,double giamGia)
        {
            // TODO: Complete member initialization
            this.STT = sTT;
            this.Ngay = ngay;
            this.NoiDung = noiDung;
            this.SoPhieu = soPhieu;
            this.NoDau = noDau;
            this.NhapHang = phatSinh;
            this.HangTra = hangTra;
            this.ThanhToan = thanhToan;
            this.NoCuoi = noCuoi;
            this.GiamGia = giamGia;
        }
        public oChiTietGiaoDich()
        {
            // TODO: Complete member initialization
        }

        public oChiTietGiaoDich(oChiTietGiaoDich x)
        {
            // TODO: Complete member initialization
            this.STT = x.STT;
            this.Ngay = x.Ngay;
            this.NoiDung = x.NoiDung;
            this.SoPhieu = x.SoPhieu;
            this.NoDau = x.NoDau;
            this.NhapHang = x.NhapHang;
            this.HangTra = x.HangTra;
            this.ThanhToan = x.ThanhToan;
            this.NoCuoi = x.NoCuoi;
            this.GiamGia = x.GiamGia;
        }
    }

    #endregion



}
   