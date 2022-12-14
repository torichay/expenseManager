<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html lang="en">
<!DOCTYPE html>
<html lang="ru">
  <head>

       <!-- Required meta tags -->
       <meta http-equiv="Content-Type" content="text/html; charset=windows-1251" />
       <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
       <title>Sign in Expense-Manager</title>
       <!-- Bootstrap CSS -->
       <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
       <link href="/css/index.css" rel="stylesheet" type="text/css"/></link>

       <!-- jQuery first, then Tether, then Bootstrap JS. -->

          <script src="https://code.jquery.com/jquery-3.1.1.slim.min.js" integrity="sha384-A7FZj7v+d/sdmMqp/nOQwliLvUsJfDHW+k9Omg/a/EheAdgtzNs3hpfag6Ed950n" crossorigin="anonymous"></script>
          <script src="https://code.jquery.com/jquery-3.3.1.js" crossorigin="anonymous"></script>
          <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb" crossorigin="anonymous"></script>
          <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>
          <script src="/js/registration.js" rel="stylesheet" type="text/javascript"></script>
          <script src='js/jquery.svg3dtagcloud.min.js'></script>
          <script src='js/index.js'></script>


  </head>

<div class="modal fade" id="modalError" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Information</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
            <center><p id="errors"></p></center>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-dismiss="modal">Ok</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="modalAbout" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Information</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
            <center><p>This is the accounting of income and expenses. To start using the application, you need to
            register a personal account, where you can create an unlimited number of accounts, clearly see expenses
            and incomes, as well as the ability to plan the budget of these accounts.</p></center>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-dismiss="modal">Ok</button>
      </div>
    </div>
  </div>
</div>

<body>
    <header class="navbar fixed-top navbar-empty">
        <div class="container">
            <a class="navbar-brand picture" href="">
                <img src="/picture/main.jpg" width="30" height="30" alt="">
            </a>
        </div>
    </header>
    <br>
    <br>

    <sec:authorize access="hasRole('USER')">
        <c:redirect url="/menu"/>
    </sec:authorize>
    <div class="container padding-container">
        <div class="row row-width">
            <div class="col-sm-7">
                <h1 class="display-4">Expense-Manager</h1>
                <div id='holder'></div>
            </div>
            <div class="col-sm-5">
                <div class="card">
                    <ul class="nav nav-tabs" id="myTab" role="tablist">
                        <li class="nav-item" role="presentation">
                            <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true"><center>Sing in</center></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false"><center>Regist</center></a>
                        </li>
                    </ul>
                    <div class="tab-content" id="myTabContent">
                        <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                            <!-- ?????????? ?????? ???????????? -->
                            <form name="loginForm" action="/login" method="post">
                                <div class="form-group te">
                                    <small><dt label for="login" class="col-form-label">Login:</label></dt></small>
                                    <input type="text" class="form-control" name="username" id="login" placeholder="Login"/>
                                </div>
                                <div class="form-group te">
                                    <small><dt label for="pass" class="col-form-label">Password:</label></dt></small>
                                    <input type="password" class="form-control" name="password" id="pass" placeholder="Password">
                                </div>
                                <br>
                                <div class="col-auto my-1 te">
                                    <div class="custom-control custom-checkbox mr-sm-2">
                                        <input type="checkbox" class="form-check-input" id="customControlAutosizing">
                                        <small><dt label class="custom-control-label" for="customControlAutosizing">Remember me</label></dt></small>
                                    </div>
                                </div>
                                <div class="form-group te">
                                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                                    <button onClick="return validateAuthorization();" type="submit" class="bttn btn-success">Sign in</button>
                                </div>
                            </form>
                        </div>
                        <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                            <!-- ?????????? ?????? ?????????????????????? -->
                            <form name="registrationForm" action="/registration" method="post">
                                <div class="form-group te">
                                    <small><dt label for="login" class="col-form-label">Login:</label></dt></small>
                                    <input type="text" class="form-control" name="login" id="login" placeholder="Login"/>
                                </div>
                                <div class="form-group te">
                                    <small><dt label for="password" class="col-form-label">Password:</label></dt></small>
                                    <input type="password" class="form-control" name="password" id="pass" placeholder="Password">
                                </div>
                                <div class="form-group te">
                                    <small><dt label for="email" class="col-form-label">Email:</label></dt></small>
                                    <input type="text" class="form-control" name="email" id="email" placeholder="@mail">
                                </div>
                                <div class="form-group te">
                                    <small><dt label for="attName" class="col-form-label">About myself:</label></dt></small>
                                    <input type="text" class="form-control" name="info" id="info" placeholder="information">
                                </div>
                                <div class="form-group te">
                                    <small><dt label for="attName" class="col-form-label">Telephone number:</label></dt></small>
                                    <input type="text" class="form-control" name="phone" id="phone" placeholder="Tel. Number">
                                </div>
                                <br>
                                <div class="form-group te">
                                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                                    <button onClick="return validateRegistration();" type="submit" class="bttn btn-success">Regist</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <p>
                <ul class="fixed-bottom nigth-footer">
                    <div class="container">
                        <div class="row">
                            <div class="footer-links text-footer">
                                <a class="col" href="" data-toggle="modal" data-target="#modalAbout">About Site</a>
                            </div>
                        </div>
                    </div>
                </ul>
            </div>
        </div>
    </div>
</body>
</html>