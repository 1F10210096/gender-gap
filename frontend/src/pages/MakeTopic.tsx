import Header from "../components/Home/header/Header";
import KaitenSushi from "../components/Home/kaitenSushi/KaitenSushi";
import styles from "./makeTopic.module.css";
import useThreadFormToDB from "../hook/makeTopic/useThreadFormToDB";
import { useGenderLogin } from "../hook/gender/useGenderLogin";
import usePostState from "../hook/createPost/usePostState";
import ImgUploadForm from "../components/CreateForm/ImgUploadForm";
import usePutImageS3 from "../hook/makeTopic/usePutImageS3";

const MakeTopic = () => {
  const { threadFormSubmit, loading, error, threadTitle, setThreadTitle } =
    useThreadFormToDB();
  const { getValidGender } = useGenderLogin();
  const { threadContext, setThreadContext } = usePostState();
  const { putImage, setSelectedFile } = usePutImageS3();
  const threadSubmit = async (event: React.FormEvent) => {
    event.preventDefault();
    setThreadTitle("");
    const imageKey = await putImage();

    await threadFormSubmit(
      event,
      setThreadContext,
      threadContext,
      getValidGender(),
      imageKey
    );
  };
  return (
    <div className={styles.body}>
      <Header />
      <KaitenSushi />
      <div className={styles.contents}>
        <div className={styles.main}>
          <div className={styles.entryWrap}>
            <div className={styles.h1}>トピックを投稿する</div>
            <div className={styles.formFlow}>img</div>
            <form className={styles.form} onSubmit={threadSubmit}>
              <div className={styles.inForm}>
                {/* イメージ追加 */}
                <div className={styles.image}>
                  <div className={styles.topicImg}></div>
                  <div className={styles.addImage}>
                    <ImgUploadForm
                      onFileSelect={(file) => setSelectedFile(file)}
                    />
                  </div>
                </div>
                {/* フォーム側 */}
                <div className={styles.other}>
                  <input
                    type="text"
                    placeholder="タイトルを書く"
                    className={styles.threadTitle}
                    value={threadTitle}
                    onChange={(e) => setThreadTitle(e.target.value)}
                    required
                  />
                  {error && <p className="text-red-500">{error}</p>}
                  <div className={styles.textarea}>
                    <textarea
                      placeholder="投稿内容を書く"
                      className={styles.wrap}
                      value={threadContext}
                      onChange={(e) => setThreadContext(e.target.value)}
                      required
                    ></textarea>
                  </div>
                </div>
              </div>
              <div className={styles.createTopicBtn}>
                <button type="submit" className={styles.btn} disabled={loading}>
                  {loading ? "送信中..." : "送信"}
                </button>
              </div>
            </form>
          </div>
        </div>
        <div className={styles.a}></div>
      </div>
    </div>
  );
};

export default MakeTopic;
