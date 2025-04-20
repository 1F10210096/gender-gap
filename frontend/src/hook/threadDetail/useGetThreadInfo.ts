import { useLocation, useParams } from "react-router-dom";
import { Thread } from "../../types/thread";
import { ThreadsPosts } from "../../types/post";
import { useEffect, useState } from "react";
import { DISCUSSION_API_URL } from "@src/config";
import axios from "axios";

interface useGetThreadInfoReturn {
  threadInfo: Thread;
  threadTitle: string;
  dateInfo: Date;
  threadImage: string | undefined;
}
const useGetThreadInfo = (): useGetThreadInfoReturn => {
  const location = useLocation();
  const { id } = useParams<{ id: string }>();
  const [threadInfo, setThreadInfo] = useState<Thread | null>(
    location.state?.thread ?? null
  );
  useEffect(() => {
    if (!threadInfo && id) {
      axios
        .get(`${DISCUSSION_API_URL}/${id}`)
        .then((res) => setThreadInfo(res.data.data))
        .catch((err) => {
          console.error("スレッド取得失敗:", err);
        });
    }
  }, [threadInfo, id]);
  if (!threadInfo) {
    return {
      threadInfo: {
        id: id ?? "",
        thread_title: "読み込み中...",
        created_at: "",
        image_key: undefined,
        votes_summary: {
          male_votes: 0,
          female_votes: 0,
        },
      },
      threadTitle: "読み込み中...",
      dateInfo: new Date(),
      threadImage: undefined,
    };
  }

  const { thread_title, created_at, image_key } = threadInfo;
  return {
    threadInfo,
    threadTitle: thread_title,
    dateInfo: new Date(created_at),
    threadImage: image_key,
  };
};

interface useGetThreadStateReturn {
  threadTitle: string;
  dateInfo: Date;
  threadImage: string | undefined;
}

export const useGetThreadState = (thread: Thread): useGetThreadStateReturn => {
  // const { id } = useParams<{ id: string }>();
  const threadTitle = thread.thread_title;
  const threadImage = thread.image_key;
  console.log(threadImage);
  const threadCreatedAt = thread.created_at;
  const dateInfo = new Date(threadCreatedAt);
  return { threadTitle, dateInfo, threadImage };
};

interface useGetPostInfoReturn {
  postContent: string;
  postId: string;
  postDateInfo: Date;
  postImage: string | null;
  gender: number;
}
export const useGetPostInfo = (post: ThreadsPosts): useGetPostInfoReturn => {
  const postContent = post.content;
  const postId = post.id;
  const postImage = post.image_key;
  const gender = post.gender;
  const postCreatedAt = post.created_at;
  const postDateInfo = new Date(postCreatedAt);

  return { postContent, postId, postDateInfo, postImage, gender };
};
export default useGetThreadInfo;
