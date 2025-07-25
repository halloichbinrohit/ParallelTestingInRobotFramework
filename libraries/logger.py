import logging
import os


logger = logging.getLogger()
logger.debug(f"*** Logger Initialized ***")


def log_to_file(message, test_name):
    # Create logs directory & logfile, if missing
    # test_name = request.node.name
    # log_file = os.path.join(os.getcwd(), "logs", f"{test_name}.log")
    # log_file = os.path.join(os.getcwd(), "logs", "api.log")
    log_dir = "logs"
    os.makedirs(log_dir, exist_ok=True)
    log_file = os.path.join(log_dir, f"{test_name}_app.log")
    # os.makedirs(os.path.dirname(log_file), exist_ok=True)

    # Replace default logger at session start
    # logger = logging.getLogger()
    logger.setLevel(logging.DEBUG)

    # File handler (new file each run)
    fh = logging.FileHandler(log_file, mode="a", encoding="utf-8")
    fh.setLevel(logging.DEBUG)
    formatter = logging.Formatter(
        "\n%(asctime)s - %(levelname)s - %(name)s : %(message)s",
        datefmt="%m-%d-%Y %I:%M:%S %p"
    )
    fh.setFormatter(formatter)

    # Stream handler (console)
    sh = logging.StreamHandler()
    sh.setLevel(logging.DEBUG)
    sh.setFormatter(formatter)

    logger.handlers.clear()
    logger.addHandler(fh)
    logger.addHandler(sh)

    # logger.debug(f"*** Logger Initialized ***")
    # sh.flush()
    # logger.removeHandler(sh)
    # sh.close()
    # fh.flush()
    # with open(log_file, "r") as f:
    #     allure.attach(f.read(), name=f"{test_name}.log", attachment_type=allure.attachment_type.TEXT)
    # logger.removeHandler(fh)
    # fh.close()
    logger.info(message)
    sh.flush()
    fh.flush()
    #logger.removeHandler(sh)
    #logger.removeHandler(fh)
    sh.close()
    fh.close()
