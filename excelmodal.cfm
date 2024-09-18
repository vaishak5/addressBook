<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./style/jquery-ui.css">
    <link rel="stylesheet" href="./style/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="./script/sourceFirst.js"></script>
      <script src="./script/sourceSecond.js"></script>
      <script src="./script/sourceThird.js"></script>
      <script src="./script/jquery.min.js"></script>
      <script src="./script/jquery-ui.min.js"></script>
      <script src="./script/validation.js"></script>
      <script src="./script/modalJS.js"></script>
      <script src="./script/reset.js"></script>
    <title>Excel Modal</title>
</head>
<body>
    <div class="excelModal">
        <img src="./assets/excel.png" alt="img" data-toggle="modal" data-target="#exampleModalCenter" id="uploadTemplate">

        <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-body">
                        <div class="heading">
                            <h4 class="head py-2 text-center">Upload Excel</h4>
                        </div>
                        <form id="uploadForm" action="" method="post" enctype="multipart/form-data">
                            <input type="file" name="excelFile" id="excelFile" required>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-primary" id="uploadAddress">Upload</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </form>


                        <div class="addfile py-2">
                            <a href="listExcel.cfm"><button type="button" class="btn btn-primary">Template with Data</button></a>
                            <a href="emptyexcel.cfm"><button type="button" class="btn btn-primary" >Plain Template</button></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
