<cfinclude template="header.cfm">

<!-- Begin Page Content -->
<div class="container-fluid">

  <!-- Page Heading -->
  <div class="d-sm-flex align-items-center justify-content-between mb-4">
    <h1 class="h3 mb-0 text-gray-800">Find courses within a mile radius</h1>
    <a href="#" class="d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-save fa-sm"></i> Save this Ambit</a>
  </div>
  <div class="row">
    <input id="searchTextField" class="form-control bg-light border-0 small" type="text" size="50" placeholder="Enter a location" autocomplete="on" runat="server" aria-label="Search" aria-describedby="basic-addon2" />
    <input type="number" class="form-control bg-light border-0 small" placeholder="Enter a mile radius up to 50 miles" id="mileRadius" name="mileRadius" min="1"  max="50" maxlength="2" oninput="mileValue()"/>
  </div>
  <input type="hidden" id="cityLat" name="cityLat" max="10"/>
  <input type="hidden" id="cityLng" name="cityLng" max="11"/>
  <div class="custom-control custom-switch" id="driving_miles_switch">
      <input type="checkbox" class="custom-control-input" id="customSwitch1" onclick="check()">
      <label class="custom-control-label" for="customSwitch1">Switch On to get driving miles</label>
    </div>
  <div>
    <button id="search_button" class="btn btn-primary" type="button">
      <i class="fas fa-search fa-sm"><span>Find Golf Courses</span></i>
    </button>
    </div>
  <div id="course_counter"></div>
  </div>
  
  
  <div id="loader"></div>
  <!-- Content Row -->
  <!--- <cfinclude template="course_locator.cfm"> --->
  <div id="course_locator" class="row">
    
  </div>
<!-- /.container-fluid -->

<cfinclude template="footer.cfm">