<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: DELETE");
header("Access-Control-Allow-Headers: Content-Type");

include "koneksi.php";

$data = json_decode(file_get_contents("php://input"), true);

if (isset($data['id'])) {
    $stmt = $conn->prepare("DELETE FROM volunteerr WHERE id = ?");
    $stmt->bind_param("i", $data['id']);

    if ($stmt->execute()) {
        echo json_encode(["message" => "Data berhasil dihapus"]);
    } else {
        echo json_encode(["error" => true, "message" => "Gagal menghapus data"]);
    }
    $stmt->close();
} else {
    echo json_encode(["error" => true, "message" => "ID tidak ditemukan"]);
}

$conn->close();
?>
