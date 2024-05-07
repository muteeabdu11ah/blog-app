# Python side code
from flutter_boost import MethodChannel, FlutterBoost

channel = MethodChannel(FlutterBoost.engine())
@channel.channel('com.example.flutter_python_bridge')
def preprocess_image(image_path):
    # Your Python script logic goes here
    img = Image.open(image_path)
    img = img.resize((128, 128))
    img_array = np.array(img)
    resized_bytes = img_array.tobytes()

    return resized_bytes
