<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: PUT");
header("Access-Control-Allow-Headers: Content-Type");

include "koneksi.php";

$data = json_decode(file_get_contents("php://input"), true);

if (
    isset($data['id']) &&
    isset($data['nama_kegiatan']) &&
    isset($data['deskripsi']) &&
    isset($data['lokasi']) &&
    isset($data['tanggal'])
) {
    $id = (int)$data['id']; // pastikan ID berupa integer

    $stmt = $conn->prepare("UPDATE volunteerr SET nama_kegiatan = ?, deskripsi = ?, lokasi = ?, tanggal = ? WHERE id = ?");
    $stmt->bind_param("ssssi", $data['nama_kegiatan'], $data['deskripsi'], $data['lokasi'], $data['tanggal'], $id);

    if ($stmt->execute()) {
        echo json_encode(["success" => true, "message" => "Data berhasil diupdate"]);
    } else {
        echo json_encode(["error" => true, "message" => "Gagal mengupdate data", "detail" => $stmt->error]);
    }

    $stmt->close();
} else {
    echo json_encode(["error" => true, "message" => "Data tidak lengkap"]);
}

$conn->close();
?>
