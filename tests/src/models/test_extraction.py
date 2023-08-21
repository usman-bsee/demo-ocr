import unittest
from unittest.mock import patch, MagicMock
from PIL import Image
from pdf2image import convert_from_path
import pytesseract
from src.models.extraction import extract_text_from_pdf

class TestExtractTextFromPdf(unittest.TestCase):
    @patch('your_module.convert_from_path')
    @patch('your_module.Image.open')
    @patch('your_module.pytesseract.image_to_string')
    def test_extract_text_from_pdf(self, mock_image_to_string, mock_open, mock_convert_from_path):
        # Mock the convert_from_path function to return a list of images
        mock_convert_from_path.return_value = [MagicMock()]

        # Mock the image_to_string function to return the extracted text
        mock_image_to_string.return_value = 'Hello World'

        # Call the function
        extracted_text = extract_text_from_pdf('path/to/pdf')

        # Assert that the convert_from_path function was called with the correct arguments
        mock_convert_from_path.assert_called_once_with('path/to/pdf')

        # Assert that the image.save function was called with the correct arguments
        mock_open.assert_called_once_with('src/data/output_image_1.png')

        # Assert that the image_to_string function was called with the correct arguments
        mock_image_to_string.assert_called_once_with(mock_open.return_value)

        # Assert that the extracted text is correct
        self.assertEqual(extracted_text, 'Hello World')

if __name__ == '__main__':
    unittest.main()