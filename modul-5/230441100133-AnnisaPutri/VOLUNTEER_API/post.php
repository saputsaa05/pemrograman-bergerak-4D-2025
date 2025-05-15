<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

include "koneksi.php";

// Ambil JSON body
$data = json_decode(file_get_contents("php://input"), true);

// Validasi input (tanpa id)
if (
    isset($data['nama_kegiatan']) &&
    isset($data['deskripsi']) &&
    isset($data['lokasi']) &&
    isset($data['tanggal'])
) {
    // Masukkan data TANPA id (biarkan auto increment)
    $stmt = $conn->prepare("INSERT INTO volunteerr (nama_kegiatan, deskripsi, lokasi, tanggal) VALUES (?, ?, ?, ?)");
    $stmt->bind_param("ssss", $data['nama_kegiatan'], $data['deskripsi'], $data['lokasi'], $data['tanggal']);

    if ($stmt->execute()) {
        echo json_encode(["success" => true, "message" => "Data berhasil ditambahkan"]);
    } else {
        echo json_encode(["error" => true, "message" => "Gagal menambah data", "detail" => $stmt->error]);
    }
    $stmt->close();
} else {
    echo json_encode(["error" => true, "message" => "Data tidak lengkap"]);
}

$conn->close();
?>
