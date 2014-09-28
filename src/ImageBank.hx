import backend.Image;
import backend.ImageFile;

/*
  Manages loading of image files and signals when loading is complete.

  Call `addImage` to queue an image file for loading. Once all required images
  are queued, you can check readiness with `isReady` or set a one-time ready
  callback (which will be called immediately if appropriate) with `onceReady`.

  Retrieve loaded images with `getImage`.
 */
class ImageBank {
	static var images : Map<String,Image> = new Map();
	static var pendingCount : Int = 0;
	static var readyCallbacks : Array<Void -> Void> = new Array();

	public static function addImage(filename : String) : Image {
		if (images.exists(filename)) {
			return images.get(filename);
		}
		pendingCount += 1;
		var image = new ImageFile(filename, function(image) {
			pendingCount -= 1;
			if (isReady()) {
				for (cb in readyCallbacks) {
					cb();
				}
				readyCallbacks = new Array();
			}
		});
		images.set(filename, image);
		return image;
	}

	public static function isReady() : Bool {
		return (pendingCount == 0);
	}

	public static function getImage(filename : String) : Null<Image> {
		return images.get(filename);
	}

	/*
	  Call `cb` once only when the image bank is done loading all pending
	  images.
	 */
	public static function onceReady(cb : Void -> Void) : Void {
		if (isReady()) {
			cb();
		} else {
			readyCallbacks.push(cb);
		}
	}

}