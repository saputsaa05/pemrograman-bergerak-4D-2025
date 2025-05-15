<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Headers: Content-Type");

header("Content-Type: application/json");
include "koneksi.php";

$result = $conn->query("SELECT * FROM volunteerr");

$data = [];
while ($row = $result->fetch_assoc()) {
    $data[] = $row;
}

echo json_encode($data);

$conn->close();
?>
