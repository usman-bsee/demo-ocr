import pytesseract
from PIL import Image
from pdf2image import convert_from_path


def extract_text_from_pdf(pdf_path):
    # Convert PDF to a list of images
    images = convert_from_path(pdf_path)

    # Save the images to files
    for i, image in enumerate(images):
        image.save(f'src/data/output_image_{i + 1}.png', 'PNG')

    # Load the image using PIL
    image = Image.open('src/data/output_image_1.png')

    # Perform OCR on the image
    extracted_text = pytesseract.image_to_string(image)

    return extracted_text






if __name__ == '__main__':
    pdf_path = 'src/data/data_file.pdf'
    extracted_text = extract_text_from_pdf(pdf_path)
    print("\n\nExtracted Text: \n", extracted_text)
