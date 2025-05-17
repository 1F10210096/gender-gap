import axios from "axios";
import { useEffect, useState } from "react";
import { DISCUSSION_THREAD_POPULAR_API_URL } from "@src/config";
import styles from "./popularTopic.module.css";
import { Link } from "react-router-dom";
import useCreatedAt from "../../../../../../hook/makeTopic/useCreatedAt";
import { Thread } from "../../../../../../types/thread";
import ThreadAndPostImage from "../../../threadAndPostImage/ThreadAndPostImage";

const PopularTopic = () => {
  const [popularThreads, setPopularThreads] = useState<Thread[]>([]);
  const { sinceDate } = useCreatedAt();

  const createSinceDate = (fullDate: Date) => {
    return sinceDate(fullDate);
  };

  useEffect(() => {
    const fetchThreadsTitle = async () => {
      try {
        const response = await axios.get(DISCUSSION_THREAD_POPULAR_API_URL, {
          headers: {
            Accept: "application/json",
          },
        });

        console.log("popularTopic:", response.data.data);
        setPopularThreads(response.data.data);
      } catch (err) {
        console.log(err);
      }
    };
    fetchThreadsTitle();
  }, []);

  return (
    <>
      {Array.isArray(popularThreads) && popularThreads.length > 0 ? (
        popularThreads.map((thread) => (
          <div key={thread.id} className="mb-6">
            <Link to={`threads/${thread.id}`} state={{ thread }} className="block">
              <div className="flex items-center gap-4 bg-white border border-gray-200 rounded-xl p-4">
                {/* 画像エリア */}
                <div className="w-16 h-16 flex-shrink-0 overflow-hidden rounded-lg bg-gray-100 border border-gray-200">
                  <ThreadAndPostImage imageKey={thread.image_key ?? null} />
                </div>

                {/* テキストエリア */}
                <div className="flex-1">
                  <div className="flex justify-between text-sm text-gray-500 mb-2">
                    <span className="font-medium text-blue-600 flex items-center">
                      <span className="mr-1">💬</span> {thread.comments_count} コメント
                    </span>
                    <span>{createSinceDate(new Date(thread.created_at))}</span>
                  </div>

                  <h2 className="text-base font-semibold text-gray-800">{thread.thread_title}</h2>
                </div>
              </div>
            </Link>
          </div>
        ))
      ) : (
        <div className="text-center text-gray-500 text-base py-8 bg-white border border-gray-200 rounded-xl">
          🚀 Loading threads...
        </div>
      )}
    </>
  );
};

export default PopularTopic;
