import { useEffect, useState } from "react";
import { getUsers } from "../services/userService";
import styles from "./home.module.css"
import Header from "../components/Home/header/Header";
import MainTopic from "../components/Home/contents/mainTopic/MainTopic";
import SubTopic from "../components/Home/contents/subTopic/SubTopic";
import KaitenSushi from "../components/Home/kaitenSushi/KaitenSushi";

const Home = () => {
    const [users, setUsers] = useState<{ id: number; name: string }[]>([]);

    useEffect(() => {
        getUsers()
            .then((data) => {
                console.log("APIレスポンス:", data);
                setUsers(data);
            })
            .catch((error) => console.error("APIエラー:", error));
    }, []);

    return (
        <div className={styles.body}>
            <Header/>
            <KaitenSushi/>
            <div className={styles.contents}>
                <MainTopic/>
                <SubTopic/>
            </div>
        </div>
    );
};

export default Home;
