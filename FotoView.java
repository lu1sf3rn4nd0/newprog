package com.porto.regulacaosinistroauto.web.service;

import java.awt.image.BufferedImage;
import java.awt.image.RenderedImage;
import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.URL;

import javax.imageio.ImageIO;
import javax.media.jai.JAI;
import javax.media.jai.PlanarImage;
import javax.media.jai.RenderedOp;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;

import com.porto.infra.util.LogManager;
import com.porto.sinistro.regulacaosinistroauto.common.ArquivoRecebidoVO;
import com.sun.media.jai.codec.ImageCodec;
import com.sun.media.jai.codec.ImageDecoder;
import com.sun.media.jai.codec.TIFFEncodeParam;

/**
 * @version 	1.0
 * @author
 */
public class FotoView extends HttpServlet {
	/**
	 * LOGGER
	 */
	private static final LogManager LOGGER = LogManager.getLog(FotoView.class);
	/**
	* @see javax.servlet.http.HttpServlet#void (javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	*/
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {

		ArquivoRecebidoVO o = (ArquivoRecebidoVO) req.getAttribute("result");

		int pagina = 1;

		if (StringUtils.isNotEmpty(req.getParameter("pagina"))) {
			pagina = Integer.valueOf(req.getParameter("pagina")).intValue();
		}

		boolean isNegative =
			req.getParameter("negative") != null
				&& req.getParameter("negative").equals("1");

		BufferedInputStream bufferedInputStream =
			new BufferedInputStream(new ByteArrayInputStream(o.getArquivo()));
		ImageDecoder dec =
			ImageCodec.createImageDecoder("tiff", bufferedInputStream, null);

		int count = 0;
		try {
			count = dec.getNumPages();

			if (pagina > count) {
				pagina = count;
			}

			TIFFEncodeParam param = new TIFFEncodeParam();
			param.setCompression(TIFFEncodeParam.COMPRESSION_GROUP4);
			param.setLittleEndian(false); // Intel

			RenderedImage page = dec.decodeAsRenderedImage(pagina-1);

			ByteArrayOutputStream byteArrayOutputStream =
				new ByteArrayOutputStream();
			RenderedOp r =
				JAI.create("encode", page, byteArrayOutputStream, "png");

			r.dispose();

			writeFoto(resp, byteArrayOutputStream.toByteArray(), isNegative);

			byteArrayOutputStream.close();

		} catch (Exception e) {
			// NAO EH TIFF	
			writeFoto(resp, o.getArquivo(), isNegative);
		}

	}

	/**
	* @see javax.servlet.http.HttpServlet#void (javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	*/
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {

	}
	/**
	 * Escreve arquivo no response
	 * @param resp  HttpServletResponse
	 * @param arquivo bytes do arquivo
	 * @param negative Negative ?
	 */
	private void writeFoto(
		final HttpServletResponse resp,
		final byte[] arquivo,
		boolean negative)
		throws IOException {
		try {

			resp.setContentType("image/png");
			ServletOutputStream os = resp.getOutputStream();

			if (negative) {
				BufferedImage image =
					ImageIO.read(new ByteArrayInputStream(arquivo));

				PlanarImage pa = JAI.create("invert", image);
				BufferedImage outImg = pa.getAsBufferedImage();
				ByteArrayOutputStream saida = new ByteArrayOutputStream();
				ImageIO.write(outImg, "png", saida);
				os.write(saida.toByteArray());
			} else {
				os.write(arquivo);
			}
			os.flush();
			os.close();

		} catch (Exception e) {
			LOGGER.error(e, e);
		}

	}

	private byte[] getImagemErro() {
		byte[] imagemErro = null;
		try {
			BufferedImage image = null;
			try {
				URL url =
					new URL("http://localhost:9080/regulacaosinistroauto/visualizador/img/imagem_nao_disponivel.jpg");
				image = ImageIO.read(url);
			} catch (IOException e) {
				LOGGER.error("image missing");
			}

			ByteArrayOutputStream baos = new ByteArrayOutputStream(1000);
			ImageIO.write(image, "jpg", baos);
			baos.flush();

			imagemErro = baos.toByteArray();
			//writeFoto(resp, imagemErro, false);
			baos.close();

		} catch (Exception e) {
			LOGGER.error(
				"[FotoView] Erro ao carregar imagem de erro: " + e.getMessage(),
				e);
		}
		return imagemErro;
	}

}
