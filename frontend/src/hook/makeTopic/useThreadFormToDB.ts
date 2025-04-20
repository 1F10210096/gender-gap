import { DISCUSSION_API_URL } from "../../config";
import { useEffect, useState } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";

interface useThreadFormToDBReturn {
  threadFormSubmit: (
    event: React.FormEvent,
    setThreadContext: (value: string) => void,
    threadContext: string,
    gender: number,
    key?: string | null
  ) => Promise<void>;
  loading: boolean;
  error: string | null;
  threadTitle: string;
  setThreadTitle: (value: string) => void;
}

const useThreadFormToDB = (): useThreadFormToDBReturn => {
  const [threadTitle, setThreadTitle] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [threadInfo, setThreadInfo] = useState<{
    thread_title: string;
    id: string;
    created_at: number;
    image_key?: string;
  }>({
    thread_title: "",
    id: "",
    created_at: 0,
    image_key: "",
  });
  const navigate = useNavigate();

  const threadFormSubmit = async (
    event: React.FormEvent,
    setThreadContext: (value: string) => void,
    threadContext: string,
    gender: number,
    image_key?: string | null
  ): Promise<void> => {
    event.preventDefault();
    setLoading(true);
    setError(null);
    const thread_title = threadTitle;
    const content = threadContext;
    const created_at = threadInfo.created_at;

    const payload = {
      discussion_thread: { thread_title, created_at, image_key },
      post: { content: content, gender: gender, image_key: image_key || null },
    };

    try {
      const response = await axios.post(DISCUSSION_API_URL, payload, {
        headers: { "Content-Type": "application/json" },
      });
      console.log(response.data.data);
      setThreadInfo(response.data.data);
      setThreadContext("");
      setThreadTitle("");
    } catch (err) {
      console.log(err);
      setError("Failed to send thread");
      return undefined;
    } finally {
      setLoading(false);
    }
  };
  useEffect(() => {
    if (threadInfo.id) {
      navigate(`/threads/${threadInfo.id}`, {
        state: {
          thread_title: threadInfo.thread_title,
          id: threadInfo.id,
          created_at: threadInfo.created_at,
        },
      });
    }
  }, [
    threadInfo.id,
    threadInfo.thread_title,
    threadInfo.created_at,
    navigate,
    threadInfo,
  ]);
  return {
    threadFormSubmit,
    loading,
    error,
    threadTitle,
    setThreadTitle,
  };
};

export default useThreadFormToDB;
