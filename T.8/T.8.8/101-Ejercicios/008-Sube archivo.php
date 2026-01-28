<?php

mkdir('uploads');

move_uploaded_file(
  $_FILES['archivo']['tmp_name'],
  'uploads/' . $_FILES['archivo']['name']
);

echo 'OK';
?>