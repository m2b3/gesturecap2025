import cv2
from video.flircam import Flircam


def main():
    # Initialize FLIR camera
    cam = Flircam()
    cam.start()

    print("Press 'q' to quit.")

    last_ts = None
    fps = 0.0

    try:
        while True:
            frame, ts, _ = cam.read_frame()
            if not frame.any():
                print("Failed to grab frame.")
                break

            # Calculate FPS from timestamp difference
            if last_ts is not None:
                dt = ts - last_ts
                if dt > 0:
                    fps = 1.0 / dt
            last_ts = ts

            # Draw overlay
            cv2.line(frame, (0, 400), (frame.shape[1], 400), (255, 0, 0), 2)
            cv2.putText(frame, f"TS: {ts:.3f}s", (30, 50), cv2.FONT_HERSHEY_SIMPLEX, 
                        1, (0, 0, 255), 2)
            cv2.putText(frame, f"FPS: {fps:.1f}", (30, 100), cv2.FONT_HERSHEY_SIMPLEX, 
                        1, (0, 255, 0), 2)

            cv2.imshow("Live Feed", frame)

            # Exit on 'q'
            if cv2.waitKey(1) & 0xFF == ord('q'):
                break

    except KeyboardInterrupt:
        pass
    finally:
        # Cleanup
        cam.cleanup()
        cv2.destroyAllWindows()


if __name__ == '__main__':
    main()
