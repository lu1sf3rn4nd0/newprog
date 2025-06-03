<%@taglib uri="/WEB-INF/tld/c.tld" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  <title>Fotos</title>
  <script type='text/javascript' src='/regulacaosinistroauto/visualizador/resources/js/jquery.js'></script>
  <script type='text/javascript'
          src='/regulacaosinistroauto/visualizador/resources/js/jquery.jqzoom-core.js'></script>

  <link rel="stylesheet" type="text/css" href="/regulacaosinistroauto/visualizador/resources/css/jquery-ui.css">
  <link rel="stylesheet" type="text/css" href="/regulacaosinistroauto/visualizador/resources/css/jquery.jqzoom.css">

  <script type='text/javascript' src="/regulacaosinistroauto/visualizador/resources/js/jquery-ui.min.js"></script>
  <script type='text/javascript' src="/regulacaosinistroauto/visualizador/resources/js/jquery.rotate.1-1.js"></script>


  <style>
    body {
      font-size: 62.5%;
    }

    label, input {
      display: block;
    }

    input.text {
      margin-bottom: 12px;
      width: 95%;
      padding: .4em;
    }

    fieldset {
      padding: 0;
      border: 0;
      margin-top: 25px;
    }

    h1 {
      font-size: 1.2em;
      margin: .6em 0;
    }

    div#users-contain {
      width: 350px;
      margin: 20px 0;
    }

    div#users-contain table {
      margin: 1em 0;
      border-collapse: collapse;
      width: 100%;
    }

    div#users-contain table td, div#users-contain table th {
      border: 1px solid #eee;
      padding: .6em 10px;
      text-align: left;
    }

    .ui-dialog .ui-state-error {
      padding: .3em;
    }

    .validateTips {
      border: 1px solid transparent;
      padding: 0.3em;
    }

  </style>

  <script type='text/javascript'>
    //<![CDATA[


    function substituirString(texto, procura, mudar) {

      if (texto != null && texto != undefined && texto != "null" && texto != '') {
        while (texto.indexOf(procura) >= 0) {
          texto = texto.substring(0, texto.indexOf(procura)) + mudar + (texto.indexOf(procura) + procura.length + 1 > texto.length ? "" : texto.substring(texto.indexOf(procura) + procura.length));
        }
      }
      return texto;
    }

    function get_url_parameter(param) {

      //verificação
      const currentUrl = window.location.href;
      const isGoogleApis = currentUrl.indexOf('googleapis') > 0;

      if (isGoogleApis) {
        return currentUrl.substring(currentUrl.indexOf("imagem=") + 7);
      } else {
        param = param.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
        const r1 = "[\\?&]" + param + "=([^&#]*)";
        const r2 = new RegExp(r1);
        const r3 = r2.exec(currentUrl);
        return r3 == null ? "" : r3[1];
      }
    }

    // function get_url_parameter(param) {
    //     if(window.location.href.indexOf('googleapis') > 0){
    //        return  window.location.href.substring(window.location.href.indexOf("imagem=")+7, window.location.href.length);
    //     }else{
    //         param = param.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
    //         var r1 = "[\\?&]" + param + "=([^&#]*)";
    //         var r2 = new RegExp(r1);
    //         var r3 = r2.exec(window.location.href);
    //         if (r3 == null) {
    //             return "";
    //         } else {
    //             return r3[1];
    //         }
    //     }
    //
    // }

    function get_url_parameter_novo(param) {
      const queryString = window.location.href.split('?')[1]; // Obtém a parte após o '?'
      if (!queryString) return ""; // Retorna vazio se não houver query string

      const params = new URLSearchParams(queryString); // Usa URLSearchParams para processar a query string
      return params.get(param); // Retorna o valor do parâmetro
    }


    function rotateDir() {
      $("#foto").rotateRight();
    }

    function rotateEsq() {
      $("#foto").rotateLeft();
    }

    function lupaMais() {
      $("#foto").width(parseInt(($("#foto").width() * 0.15) + $("#foto").width()));
      $("#foto").height(parseInt(($("#foto").height() * 0.15) + $("#foto").height()));
    }

    function lupaMenos() {
      $("#foto").width(parseInt($("#foto").width() - ($("#foto").width() * 0.15)));
      $("#foto").height(parseInt($("#foto").height() - ($("#foto").height() * 0.15)));


    }

    function negative() {
      var src = $("#foto").attr("src");

      $("#loadingDiv").show();

      if (src.indexOf("carregarArquivo.doss") == -1) {
        src = "/regulacaosinistroauto/carregarArquivo.doss?cryptFilePath=";
        src += $("#foto").attr("src");

        //	src += "&pagina=1";

        //	src = src.replace("cryptFilePath","chavetiff");
      }
// 	src = src.replace("carregarArquivo.doss", "FotoView");

      if (src.indexOf("negative") != -1) {
        src = src.replace("&negative=1", "");
      } else {
        src += "&negative=1";
      }
      $("#foto").attr("src", src);
    }

    function proximaPagina() {
      // Aqui somente se for TIFF
      var src = $("#foto").attr("src");//get_url_parameter("imagem");

      if (src.indexOf("carregarArquivo.doss") == -1) {
        return;
      }
      var pagina = parseInt(getParameter(src, "pagina"));

      if (isNaN(pagina)) {
        pagina = 1;
      }

      pagina++;
      $("#loadingDiv").show();
      //alert("/regulacaosinistroauto/carregarArquivo.doss?cryptFilePath=" + getParameter(src, "cryptFilePath") + "&pagina=" + pagina);
      $("#foto").attr("src", "/regulacaosinistroauto/carregarArquivo.doss?cryptFilePath=" + getParameter(src, "cryptFilePath") + "&pagina=" + pagina);
    }

    function paginaAnterior() {
      var src = $("#foto").attr("src");//get_url_parameter("imagem");

      if (src.indexOf("carregarArquivo.doss") == -1) {
        return;
      }

      var pagina = parseInt(getParameter(src, "pagina"));

      if (isNaN(pagina)) {
        pagina = 1;
      } else {
        pagina--;
        if (pagina == 0) pagina = 1;
      }


      $("#loadingDiv").show();
      //alert("/regulacaosinistroauto/carregarArquivo.doss?cryptFilePath=" + getParameter(src, "cryptFilePath") + "&pagina=" + pagina);
      $("#foto").attr("src", "/regulacaosinistroauto/carregarArquivo.doss?cryptFilePath=" + getParameter(src, "cryptFilePath") + "&pagina=" + pagina);

    }

    function getParameter(url, paramName) {
      url = url.substr(url.indexOf("?") + 1);
      var params = url.split("&");

      for (var i = 0; i < params.length; i++) {
        if (params[i].split("=")[0] == paramName) {
          return params[i].split("=")[1];
        }
      }
      return "";

    }

    /*
    function carregar() {
      formatarEmail();

     $("#loadingDiv").show();
      var v_imagem = get_url_parameter("imagem");
      document.getElementById("foto").src = v_imagem;
    }
    */

    /*
    function rotateDir() {
        $("[name=foto]").each(function(){
            $(this).rotateRight();
        });

    //	$("#foto").rotateRight();
    }
    function rotateEsq() {
        $("[name=foto]").each(function(){
            $(this).rotateLeft();
        });

    //	$("#foto").rotateLeft();
    }
    function lupaMais() {
        $("[name=foto]").each(function(){
            $(this).width(parseInt(($(this).width() * 0.15) + $(this).width()));
            $(this).height(parseInt(($(this).height() * 0.15)+$(this).height()));
        });
    }
    function lupaMenos() {
        $("[name=foto]").each(function(){
            $(this).width(parseInt ($(this).width() - ($(this).width() * 0.15) ));
            $(this).height(parseInt($(this).height()- ($(this).height() * 0.15)));
        });
    }
    function negative() {
        $("[name=foto]").each(function(){
             var src = $(this).attr("src") ;

             if (src.indexOf("carregarArquivo.doss") != -1) {
                 src += "&pagina=1";
                 src = src.replace("cryptFilePath","chavetiff");
             }
             src = src.replace("carregarArquivo.doss", "FotoView");

             if (src.indexOf("negative")!=-1) {
                 src = src.replace("&negative=1", "");
             } else {
                 src += "&negative=1";
             }
             $(this).attr("src", src);
         });

    }
    g_cont = 1;
    function proximaPagina() {
        var chave =  $("#foto").attr("src");
        chave = getParameter(chave, "cryptFilePath");

        g_cont++;
        $("#loadingDiv").show();

        $("#divContainer").append("<br><br><img src='' name='foto' id='foto_" + g_cont + "' border='0' onload='carregouImagem()'>");

        $("#foto_" + g_cont).attr("src","/regulacaosinistroauto/FotoView?chavetiff=" + chave + "&pagina=" + g_cont);

    }

    function proximaPaginaxx() {
        var chave =  $("#foto").attr("src");//get_url_parameter("imagem");

        if (chave.indexOf("FotoView") != -1) {
            var pagina = parseInt(getParameter(chave, "pagina"));
            chave = getParameter(chave, "chavetiff");
            pagina++;
            $("#loadingDiv").show();
            $("#foto").attr("src","/regulacaosinistroauto/FotoView?chavetiff=" + chave + "&pagina=" + pagina);
        } else {
            chave = getParameter(chave, "cryptFilePath");
            $("#loadingDiv").show();
            $("#foto").attr("src","/regulacaosinistroauto/FotoView?chavetiff=" + chave + "&pagina=2");
        }
    }
    function paginaAnterior() {
        var chave =  $("#foto").attr("src");//get_url_parameter("imagem");

        if (chave.indexOf("FotoView") != -1) {
            var pagina = parseInt(getParameter(chave, "pagina"));
            chave = getParameter(chave, "chavetiff");
            pagina--;

            if (pagina>0) {
                $("#loadingDiv").show();
                $("#foto").attr("src","/regulacaosinistroauto/FotoView?chavetiff=" + chave + "&pagina=" + pagina);
            }

        }
    }
    */
    function getParameter(url, paramName) {
      url = url.substr(url.indexOf("?") + 1);
      var params = url.split("&");

      for (var i = 0; i < params.length; i++) {
        if (params[i].split("=")[0] == paramName) {
          return params[i].split("=")[1];
        }
      }
      return "";

    }

    function carregar() {

      const currentUrl = window.location.href;
      const isGoogleApis = currentUrl.indexOf('googleapis') > 0;

      $("#loadingDiv").show();

      var v_imagem = get_url_parameter("imagem");

      if (isGoogleApis) {
        console.log("[carregar] Iniciando v_imagem.", v_imagem);
        document.getElementById("foto").src = v_imagem;
      } else {
        console.log("[carregar] Iniciando v_imagem.", v_imagem);
        document.getElementById("foto").src = "/regulacaosinistroauto/saferetriever?f="+v_imagem;
      }
    }

    function formatarEmail() {
      // a workaround for a flaw in the demo system (http://dev.jqueryui.com/ticket/4375), ignore!
      $("#dialog:ui-dialog").dialog("destroy");

      var name = $("#name"),
              email = $("#email"),
              mensagem = $("#mensagem"),
              allFields = $([]).add(name).add(email).add(mensagem),
              tips = $(".validateTips");

      var ramoAnoSinistroSequencia = $("#ramoAnoSinistroSequencia"),
              allFieldsCopiar = $([]).add(ramoAnoSinistroSequencia),
              tips = $(".validateTips");


      function updateTips(t) {
        tips
                .text(t)
                .addClass("ui-state-highlight");
        setTimeout(function () {
          tips.removeClass("ui-state-highlight", 1500);
        }, 500);
      }

      function checkLength(o, n, min, max) {
        if (o.val().length > max || o.val().length < min) {
          o.addClass("ui-state-error");
          updateTips(n + " deve ter entre " +
                  min + " e " + max + " caracteres.");
          return false;
        } else {
          return true;
        }
      }

      function checkRegexp(o, regexp, n) {
        if (!(regexp.test(o.val()))) {
          o.addClass("ui-state-error");
          updateTips(n);
          return false;
        } else {
          return true;
        }
      }

      $("#dialogMail").dialog({
        autoOpen: false,
        height: 400,
        width: 350,
        modal: true,
        buttons: {
          "Enviar": function () {
            var bValid = true;
            allFields.removeClass("ui-state-error");

            bValid = bValid && checkLength(name, "Nome", 3, 50);
            bValid = bValid && checkLength(email, "Email", 6, 80);
            bValid = bValid && checkLength(mensagem, "Mensagem", 0, 255);

            //bValid = bValid && checkRegexp( name, /^[a-z]([0-9a-z_])+$/i, "Username may consist of a-z, 0-9, underscores, begin with a letter." );
            bValid = bValid && checkRegexp(name, /^[a-z]([0-9a-z_])+$/i, "Digite o nome corretamente");
            // From jquery.validate.js (by joern), contributed by Scott Gonzalez: http://projects.scottsplayground.com/email_address_validation/
            bValid = bValid && checkRegexp(email, /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i, "Formato nome.sobrenome@portoseguro.com.br");
//					bValid = bValid && checkRegexp( mensagem, /^([0-9a-zA-Z])+$/, "Password field only allow : a-z 0-9" );

            if (bValid) {
              /* */
              alert("E-mail enviado com sucesso");


              $(this).dialog("close");
            }
          },
          Cancel: function () {
            $(this).dialog("close");
          }
        },
        close: function () {
          allFields.val("").removeClass("ui-state-error");
        }
      });
      $("#dialogCopiar").dialog({
        autoOpen: false,
        height: 250,
        width: 250,
        modal: true,
        buttons: {
          "Copiar": function () {
            var bValid = true;
            allFieldsCopiar.removeClass("ui-state-error");
            var mensagem = "Digite o sinistro corretamente.";
            var ramo = ramoAnoSinistroSequencia.val().substr(0, 3);
            var ano = ramoAnoSinistroSequencia.val().substr(3, 4);
            var sinistro = ramoAnoSinistroSequencia.val().substr(7);
            var sequencia = 0;

            if (ramo == "531" && ano.length == 4 && sinistro.length > 0) {
            } else if (ramo == "553" && ano.length == 4 && sinistro.length > 2) {
              sequencia = sinistro.substr(sinistro.length - 2);
              sinistro = sinistro.substr(0, sinistro.length - 2);
            } else {
              bValid = false;
              ramoAnoSinistroSequencia.addClass("ui-state-error");
              updateTips(mensagem);
            }

            if (bValid) {
              /* */
              alert("Documento copiado com sucesso.");
              $(this).dialog("close");
            }
          },
          Cancel: function () {
            $(this).dialog("close");
          }
        },
        close: function () {
          allFieldsCopiar.val("").removeClass("ui-state-error");
        }
      });

    }

    function enviarPorEmail() {
      $("#dialogMail").dialog('open');
    }


    function copiarProcesso() {
//updateTips("");
      $("#dialogCopiar").dialog('open');
    }

    function download() {
      //chave = getParameter($("#foto").attr("src"), "cryptFilePath");

      chave = $("#foto").attr("src");
      var prop = 'left=' + screen.availWidth * 0.4 + ',top=' + screen.availHeight * 0.4 + ',toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=no,resizable=0,width=1,height=1;'
      var janela = window.open("visualizarDocumento.doss?filePath=" + chave, "VisualizarDocumento", prop).focus();
    }

    //]]>

    function carregouImagem() {
      $("#loadingDiv").hide();
      /*
      if (g_cont < 5) {
          proximaPagina();
      }
      */
    }

    function aumentarDiminuirFrame() {
      window.parent.aumentarDiminuir(window.frameElement.id.split('frame_')[1]);
    }
  </script>

</head>
<body onload="carregar();">
<div id="loadingDiv" style="position: absolute;top: 50%;left: 50%;"><img title="Carregando..." alt="Carregando..."
                                                                         src="resources/img/loading-countdown.gif"/>
</div>
<div id="divContainer">
  <!--
  <OBJECT CLASSID="clsid:02BF25D5-8C17-4B23-BC80-D3488ABDDC6B" WIDTH="100%" HEIGHT="100%" CODEBASE="qtplugin.cab" style="display: none">
  <PARAM name="SRC" VALUE="">
  <PARAM name="SCALE" VALUE="aspect">
  </OBJECT>
  -->
  <img src="" id="foto" name='foto' border="0" onload="carregouImagem()" ondblclick="aumentarDiminuirFrame()">

</div>
<!--
<div id="dialogMail" title="Enviar documento por e-mail">
	<p class="validateTips">Informe os campos abaixo:</p>

	<form>
	<fieldset>
		<label for="name">Nome:</label>
		<input type="text" name="name" id="name" class="text ui-widget-content ui-corner-all"  />
		<label for="email">Para:</label>
		<input type="text" name="email" id="email" value="" class="text ui-widget-content ui-corner-all"   />
		<label for="mensagem">Mensagem:</label>
		<TEXTAREA name="mensagem" id="mensagem" rows="10" cols="40"></TEXTAREA>
	</fieldset>
	</form>
</div>


<div id="dialogCopiar" title="Copiar para outro processo" >
	<p class="validateTips">Informe o sinistro:</p>

	<form>
	<fieldset>
		<label for="ramoAnoSinistroSequencia">Sinistro:</label>
		<input type="text" name="ramoAnoSinistroSequencia" id="ramoAnoSinistroSequencia" class="text ui-widget-content ui-corner-all" size="14" />
		
	</fieldset>
	</form>
</div>
-->
</body>


</html>

